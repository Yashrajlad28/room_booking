class Api::V1::RoomsController < ApiController

  def search
    if params[:date].present? && params[:start].present? && params[:end].present?
      @rooms = Room.available_between(params[:date], params[:start], params[:end])
      render json: @rooms
    else
      render json: { error: "Please provide date, start_time, and end_time" }, status: :bad_request
    end
  end

  def index
    @rooms = Room.all
    # Map through rooms and add the 'is_available' key dynamically
    render json: @rooms.map { |room| 
      room.as_json.merge(is_available: !room.currently_booked?) 
    }
  end

  # change this method so that it shows all bookings for 
  # that room, implement next nearest avaliable slot feature
  def show
    @room = Room.find(params[:id])
    render json: @room
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Room not found" }, status: :not_found
  end
end
