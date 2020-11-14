class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :edit, :destroy]
    
  def index
    @events = Event.all
  end

  def show; end

  def new 
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Event create successfull."
      redirect_to action: :show, id: @event.id
    else
      render :new
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      flash[:notice] = "Event update successfull."
      redirect_to action: :show, id: @event.id
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    flash[:notice] = "Event destroyed successfull."
    redirect_to action: :index
  end
  

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:what)
  end
end
