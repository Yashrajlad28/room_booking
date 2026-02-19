class Room < ApplicationRecord
    has_many :bookings
    has_many :users, through: :bookings

    before_validation :remove_extra_spaces

    validates :name, presence: true, format: { with: /\A[A-Za-z ]+\z/ }

    def currently_booked?
        current_time = Time.now
        bookings.where(booking_date: Date.today)
                .where("start_time <= ? AND end_time > ?", current_time, current_time)
                .exists?
    end

    private 
    
    def remove_extra_spaces
        self.name = name.squish if name.present?
    end


end
