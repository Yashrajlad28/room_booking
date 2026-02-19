class Api::V1::BookingsController < ApplicationController
  # GET /api/v1/bookings
  def index
    # We use .includes to avoid "N+1" queries, making the API faster
    @bookings = Booking.includes(:user, :room).all
    render json: @bookings.as_json(include: { 
      user: { only: :name }, 
      room: { only: :name } 
    })
  end

  # POST /api/v1/bookings
  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      render json: @booking, status: :created
    else
      # Returns the validation errors (like the overlap error we wrote!)
      render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :room_id, :booking_date, :start_time, :end_time)
  end
end
