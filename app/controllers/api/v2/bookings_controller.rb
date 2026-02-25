class Api::V2::BookingsController < ApplicationController
    def index
        @bookings = Booking.all
    end
end