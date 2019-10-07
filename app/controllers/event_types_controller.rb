class EventTypesController < ApplicationController

  # GET /event_types
  def getEventType
    @event_types = EventType.all

    render json: @event_types, only: [:id, :name]
  end

  
end
