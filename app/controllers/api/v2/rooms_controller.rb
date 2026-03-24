class Api::V2::RoomsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_room, only: [:show, :update, :destroy]

    def index
        @rooms = Room.all
    end

    def show
    end

    def new
        @room = Room.new
        authorize @room
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private 

    def set_room
        @room = Room.find(params[:id])
    end
    


end