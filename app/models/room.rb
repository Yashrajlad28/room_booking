class Room < ApplicationRecord
    has_many :bookings
    has_many :users, through: :bookings

    before_validation :remove_extra_spaces

    validates :name, presence: true, format: { with: /\A[A-Za-z ]+\z/ }

    def currently_booked?
        # rails considers UTC by default for time
        # or you can config timezone in application.rb file


        # THIS DOES NOT WORK BECAUSE I WAS TRYING TO USE 
        # RUBY / RAILS METHOD seconds_since_midnight
        # IN POSTGRESQL
        # current_time = Time.current.seconds_since_midnight
        # bookings.where(booking_date: Date.today)
        #         .where(
        #             "start_time.seconds_since_midnight <= ? AND 
        #             end_time.seconds_since_midnight > ?", current_time, current_time)
        #         .exists?



        now = Time.current
        bookings.where(booking_date: Date.today)
                .where("start_time::time <= ?::time AND end_time::time > ?::time", now, now)
                .exists?

    end

    private 
    
    def remove_extra_spaces
        self.name = name.squish if name.present?
    end


end
