class RoomsController < ApplicationController
  before_filter :find_room, :only => :show

  def index
    @room = Room.new

    @rooms = Room.all
  end

  def show
    respond_to do |format|
      format.json {
        render :json => @room.to_json(
          :include => :participants
        )
      }
      format.html
    end
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(params[:room])
    if @room.save
      redirect_to room_path(@room)
    else
      render :new
    end
  end

  private
  def find_room
    @room = Room.find(params[:id])
  end
end
