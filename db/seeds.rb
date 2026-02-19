# db/seeds.rb

# 1. CLEANUP
puts "Cleaning database..."
Booking.destroy_all
User.destroy_all
Room.destroy_all

# 2. CREATE USERS
puts "Creating 10 random users..."
10.times do
  User.create!(
    name: Faker::Name.name, 
    department: Faker::Job.field
  )
end

# 3. CREATE ROOMS
puts "Creating 5 random rooms..."
5.times do
  Room.create!(
    name: "#{Faker::Commerce.color.capitalize} Conference Room",
    booked: [true, false].sample
  )
end

# 4. CREATE BOOKINGS (Now that Users and Rooms actually exist!)
puts "Creating 15 random bookings..."
user_ids = User.pluck(:id)
room_ids = Room.pluck(:id)

15.times do
  start_hour = rand(8..17)
  
  # Use create (without !) inside the loop or stick with the rescue block
  begin
    Booking.create!(
      user_id: user_ids.sample,
      room_id: room_ids.sample,
      booking_date: Faker::Date.between(from: Date.today, to: 1.month.from_now),
      start_time: Time.zone.parse("#{start_hour}:00"),
      end_time: Time.zone.parse("#{start_hour + 1}:00")
    )
  rescue ActiveRecord::RecordInvalid
    puts "Skipping an overlapping booking..."
  end
end

puts "Done! Seeded #{User.count} users, #{Room.count} rooms, and #{Booking.count} bookings."