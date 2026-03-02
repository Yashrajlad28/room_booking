class Api::V2::BookingsController < ApplicationController

    before_action :authenticate_user!

    def index
        # Only Admin can view this
        # @bookings = Booking.includes(:user, :room).all
        @bookings = current_user.bookings
    end

    def new 
        @booking = Booking.new
    end

    def create
        @booking = current_user.bookings.build(booking_params)

        if @booking.save
            redirect_to api_v2_bookings_path, notice: "Room successfully booked!"
        else
            flash.now[:alert] = "Booking creation failed"
            render :new, status: :unprocessable_entity
        end
    end

    private 

    def booking_params
        params.require(:booking).permit(:room_id, :booking_date, :start_time, :end_time)
    end

end