puts "Cleaning database..."
Booking.destroy_all
User.destroy_all
Room.destroy_all

puts "Creating 5 random rooms..."
5.times do
  Room.create!(
    name: "#{Faker::Commerce.color.capitalize} Conference Room"
  )
end

puts "Creating 6 unique users..."

users_data = [
  { name: "Satej Patil", email: "satej@example.com", dept: "IT" },
  { name: "Ananya Pandey",  email: "ananya@example.com", dept: "HR" },
  { name: "Rohan Kumbhar",   email: "rohan@example.com", dept: "Operations" },
  { name: "Sana Sonar",    email: "sana@example.com", dept: "Marketing" },
  { name: "Vikram Vetal",  email: "vikram@example.com", dept: "Finance" },
  { name: "Priya Aurora",   email: "priya@example.com", dept: "Design" }
]

users_data.each do |data|
  User.create!(
    name: data[:name],
    email: data[:email],
    password: "password123",
    password_confirmation: "password123",
    department: data[:dept]
  )
end

puts "Successfully created #{User.count} users!"