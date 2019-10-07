class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # POST /event
  def addEvent
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

    # PATCH/PUT /event/1
    def updateEvent
      if @event.update(event_params)
        render json: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  # GET /event
  def getEvent
    @events = Event.all

    render json: @events
  end

  # GET /event/1
  def getEventById
    render json: @event
  end

  # DELETE /event/1
  def destroy
    @event.destroy
  end

  def search_event
    @events = Event::Reducer.apply(params)
    render json: @events
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:title, :start_date, :end_date, :street, :neighborhood, :city, :reference_point, :description, :event_type_id, :user_id, :status)
    end
end
