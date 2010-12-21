class ContestsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_room, :only => [:show, :giveup, :update_score]

  def index
    @room = Room.new

    @rooms = Room.all
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

  def show
    @participant = current_user.participants.find_or_create_by_room_id(@room.id)
    @participants = @room.participants

    Pusher['dashboard_room_' + @room.id.to_s].trigger('participant-create', @participant.attributes)
  end

  def giveup
    @participant = current_user.participants.where(:room_id => @room.id).first
    if @participant
      @participant.destroy
      Pusher['dashboard_room_' + @room.id.to_s].trigger('participant-leave', @participant.attributes)
    end
    render :text => "OK"
  end

  def update_score
    if (@room.is_finished)
      render :text => "OK" and return
    end
    
    @participant = current_user.participants.find_or_create_by_room_id(@room.id)
    @participant.update_attribute(:score, params[:score])

    if (Integer(params[:score]) > 500 )
      @room.update_attribute(:is_finished, true)
      Pusher['dashboard_room_' + @room.id.to_s].trigger('game-finished')
      Pusher['room_' + @room.id.to_s].trigger('game-finished')
    end

    render :text => "OK"
  end

  private
  def find_room
    @room = Room.find(params[:id])
  end
end
