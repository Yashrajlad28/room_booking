class Api::V1::RoomsController < ApplicationController
  def index
    @rooms = Room.all
    # no need of created_at & updated_at
    render json: @rooms.as_json(only: [:id, :name, :booked])
  end

  def show
    @room = Room.find(params[:id])
    render json: @room
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Room not found" }, status: :not_found
  end
end
