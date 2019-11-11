class EventsController < ApplicationController
  before_action :set_event, only: [:updateEvent, :getEventById, :destroy]

  # POST /event
  def addEvent
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :ok, location: @event
    else
      render json: @event.errors, status: :bad_request
    end
  end

    # PATCH/PUT /event/1
    def updateEvent
      if @event.update(event_params)
        render json: @event, status: :ok
      else
        render json: @event.errors, status: :bad_request
      end
    end
  # GET /event
  def getEvent
    if @events = Event.all
      render json: @events, except: [:created_at, :updated_at], status: :ok
    else
      render json: @events.errors, status: :bad_request
    end
  end

  # GET /event/1
  def getEventById
    render json: @event, except: [:created_at, :updated_at], status: :ok
  end

  # DELETE /event/1
  def destroy
    if @event.update(status: false) 
      render @event.status, status: :ok
    else
      render json: @event.errors, status: :bad_request
    end
  end

  def searchEvent
    if params[:rdate] && ( params[:start_date] || params[:end_date])
      render json: {"message" => "rdate não pode ser passado como parameto junto de start_date ou end_date"}
    else
      @events = Event::Reducer.apply(params)
      render json: @events, except: [:created_at, :updated_at]
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      if @event = Event.find(params[:id])
      else
        render json: @event.errors, status: :bad_request
      end
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:title, :startDate, :endDate, :street, :neighborhood, :city, :reference_point, :description, :event_type_id, :user_id, :status)
    end
end
