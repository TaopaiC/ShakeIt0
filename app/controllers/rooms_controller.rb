class RoomsController < ApplicationController
  before_filter :find_room, :only => :show

  def index
    @room = Room.new

    @rooms = Room.all
  end

  def show
    @participants = @room.participants
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(params[:room])
    if @room.save
      redirect_to contest_path(@room)
    else
      render :new
    end
  end

  private
  def find_room
    @room = Room.find(params[:id])
  end
end
