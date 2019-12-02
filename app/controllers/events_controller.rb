class EventsController < ApplicationController
  before_action :set_event, only: [:updateEvent, :getEventById, :destroy]

  # POST /event
  def addEvent
    @event = Event.new(event_params)
    if @event.save
      render json: {msg: "salvo!"}, status: :ok, location: @event
    else
      render json: @event.errors, status: :bad_request
    end
  end

    # PATCH/PUT /event/1
    def updateEvent
      if @event.update(event_params)
         @aux = jsonid()
        render json: @aux, status: :ok
      else
        render json: @aux.errors, status: :bad_request
      end
    end
  # GET /event
    def getEvent
      @events = Event.all
      if @aux = jsonall()
        render json: @aux, except: [:created_at, :updated_at], status: :ok
      else
        render json: @events.errors, status: :bad_request
      end
    end

  # GET /event/1
  def getEventById
    @aux = jsonid()
    render json: @aux, except: [:created_at, :updated_at], status: :ok
  end

  # DELETE /event/1
  def destroy
    if @event.update(status: false) 
      render json: {msg: "Evento Excluido!" }, status: :ok
    else
      render json: @event.errors, status: :bad_request
    end
  end

  def searchEvent
    if params[:rdate] && ( params[:start_date] || params[:end_date])
      render json: {"message" => "rdate não pode ser passado como parameto junto de start_date ou end_date"}
    else
      @events = Event::Reducer.apply(params)
      @aux = jsonall()
      render json: @aux, except: [:created_at, :updated_at]
    end
  end

  private

  def jsonall()
    @aux = []
    @events.each do |event|
      @participants = event.participants
      if @participants != []
        @participants.each do |participant|
          @aux.push({
            "participant": [
              {
                "id": participant.id,
                "username": participant.user.username,
                "registrationDate": participant.registrationDate
              }
            ],
            "endDate": event.endDate,
            "city": event.city,
            "street": event.street,
            "description": event.description,
            "id": event.id,
            "neighborhood": event.neighborhood,
            "eventType": {
              "name": event.eventType.name,
              "id": event.eventType.id
            },
            "title": event.title,
            "user": {
              "birthdate": event.owner.birthdate,
              "sex": event.owner.sex,
              "id": event.owner.id,
              "email": event.owner.email,
              "username": event.owner.username
            },
            "startDate": event.startDate,
            "referencePoint": event.referencePoint,
            "status": event.status
          })
        end
      else
        @aux.push({
          "participant": [
          ],
          "endDate": event.endDate,
          "city": event.city,
          "street": event.street,
          "description": event.description,
          "id": event.id,
          "neighborhood": event.neighborhood,
          "eventType": {
            "name": event.eventType.name,
            "id": event.eventType.id
          },
          "title": event.title,
          "user": {
            "birthdate": event.owner.birthdate,
            "sex": event.owner.sex,
            "id": event.owner.id,
            "email": event.owner.email,
            "username": event.owner.username
          },
          "startDate": event.startDate,
          "referencePoint": event.referencePoint,
          "status": event.status
        })
    end
  end
            return @aux
  end

  def jsonid()
    @aux = []
      @participants = @event.participants
      if @participants != []
        @participants.each do |participant|
          @aux.push({
            "participant": [
              {
                "id": participant.id,
                "username": participant.user.username,
                "registrationDate": participant.registrationDate
              }
            ],
            "endDate": @event.endDate,
            "city": @event.city,
            "street": @event.street,
            "description": @event.description,
            "id": @event.id,
            "neighborhood": @event.neighborhood,
            "eventType": {
              "name": @event.eventType.name,
              "id": @event.eventType.id
            },
            "title": @event.title,
            "user": {
              "birthdate": @event.owner.birthdate,
              "sex": @event.owner.sex,
              "id": @event.owner.id,
              "email": @event.owner.email,
              "username": @event.owner.username
            },
            "startDate": @event.startDate,
            "referencePoint": @event.referencePoint,
            "status": @event.status
          })
        end
      else
        @aux.push({
          "participant": [
          ],
          "endDate": @event.endDate,
          "city": @event.city,
          "street": @event.street,
          "description": @event.description,
          "id": @event.id,
          "neighborhood": @event.neighborhood,
          "eventType": {
            "name": @event.eventType.name,
            "id": @event.eventType.id
          },
          "title": @event.title,
          "user": {
            "birthdate": @event.owner.birthdate,
            "sex": @event.owner.sex,
            "id": @event.owner.id,
            "email": @event.owner.email,
            "username": @event.owner.username
          },
          "startDate": @event.startDate,
          "referencePoint": @event.referencePoint,
          "status": @event.status
        })
      end

    
            return @aux
  end


    # Use callbacks to share common setup or constraints between actions.
    def set_event
      if @event = Event.find(params[:id])
      else
        render json: @event.errors, status: :bad_request
      end
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:title, :startDate, :endDate, :street, :neighborhood, :city, :referencePoint, :description, :eventTypeId, :ownerId, :status)
    end
end
