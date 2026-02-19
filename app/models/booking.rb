class Booking < ApplicationRecord
    belongs_to :user
    belongs_to :room

    validate :room_availability

  
    private

    def room_availability
        # We add '::time' to the placeholders to tell Postgres the exact data type
        overlapping_bookings = Booking.where(room_id: room_id, booking_date: booking_date)
                                        .where.not(id: id)
                                        .where("(start_time, end_time) OVERLAPS (?::time, ?::time)", start_time, end_time)

        if overlapping_bookings.exists?
            errors.add(:base, "Room is already booked for this time slot")
        end
    end

end
