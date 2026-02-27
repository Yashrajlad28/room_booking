class Api::V2::BookingsController < ApplicationController

    before_action :authenticate_user!

    def index
        # Only Admin can view this
        @bookings = Booking.includes(:user, :room).all
    end

    def new 
        @booking = Booking.new
    end
end