class Api::V2::BookingsController < ApplicationController

    before_action :authenticate_user!

    def index
        # Only Admin can view this
        # @bookings = Booking.includes(:user, :room).all
        @bookings = current_user.bookings
    end

    def new 
        @booking = Booking.new

        if params[:booking_date].present? && params[:start_time].present? && params[:end_time].present?

            @available_rooms = Room.available_between(
                params[:booking_date], 
                params[:start_time], 
                params[:end_time]
            )
        end

    end

    def create
        @booking = current_user.bookings.build(booking_params)

        if @booking.save
            redirect_to api_v2_bookings_path, notice: "Room successfully booked!"
        else
            # flash.now[:alert] = @booking.errors.full_messages.to_sentence
            flash.now[:alert] = @booking.errors.full_messages.join(", ")
            render :new, status: :unprocessable_entity
        end
    end

    def show
    end

    def destroy
        @booking = Booking.find(params[:id])
        if @booking.destroy
            flash[:notice] = "Booking successfully deleted"
        else 
            flash.now[:alert] = "Cannot be deleted"
        end
        redirect_to api_v2_bookings_path
    end

    private 

    def booking_params
        params.require(:booking).permit(:room_id, :booking_date, :start_time, :end_time)
    end

end