class Booking < ApplicationRecord
    belongs_to :user
    belongs_to :room

    validate :room_availability
    validate :booking_time_must_be_valid

    after_create :cleanup_old_bookings

  
    private

    def cleanup_old_bookings
        # This is not the best way since, this query will
        # run everytime new booking is created
        # A Rake task can be used here
        # CRON
        Booking.where("booking_date < ?", Date.today - 7).delete_all
    end

    def booking_time_must_be_valid
    # 1. Date cannot be in the past
        if booking_date < Date.today
            errors.add(:booking_date, "cannot be in the past")
            return
        end

        # 2. Date cannot be more than 1 week away
        if booking_date > 1.week.from_now.to_date
            errors.add(:booking_date, "can only be booked up to 1 week in advance")
            return
        end

        # 3. If booking for today, start_time cannot be in the past
        if booking_date == Date.today
            # We use our 'now_on_dummy_date' trick again to compare times accurately
            now = Time.current
            if start_time.strftime("%H:%M") < now.strftime("%H:%M")
            errors.add(:start_time, "cannot be in the past for today's bookings")
            end
        end
    end

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
