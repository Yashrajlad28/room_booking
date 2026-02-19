class Api::V1::RoomsController < ApplicationController
  def index
    @rooms = Room.all
    # Map through rooms and add the 'is_available' key dynamically
    render json: @rooms.map { |room| 
      room.as_json.merge(is_available: !room.currently_booked?) 
    }
  end

  def show
    @room = Room.find(params[:id])
    render json: @room
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Room not found" }, status: :not_found
  end
end
