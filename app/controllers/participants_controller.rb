class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:show, :update, :destroy]

  # GET /participants
  def index
    @participants = Participant.all

    render json: @participants, except: [:created_at, :updated_at]
  end

  # GET /participants/1
  def show
    render json: @participant, except: [:created_at, :updated_at]
  end

  # GET /participants/user/1
  def getParticipantUserID
    @participant = Participant.where(user_id: 11)
    render json: @participant.map{|part| Event.where(id: part.event_id)} , except: [:created_at, :updated_at]
  end

  @participant.map{|part| Event.where(id: part.event_id)}

  
  # GET /participants/event/1
  def getParticipantEventID
    @participant = Participant.where(event_id: params[:id])
    render json: @participant, except: [:created_at, :updated_at]
  end

  # POST /participants
  def create
    @participant = Participant.new(participant_params)

    if @participant.save
      render json: @participant, status: :created, location: @participant
    else
      render json: @participant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /participants/1
  def update
    if @participant.update(participant_params)
      render json: @participant, except: [:created_at, :updated_at]
    else
      render json: @participant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /participants/1
  def destroy
    @participant.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def participant_params
      params.require(:participant).permit(:event_id, :user_id, :registrationdate, :message)
    end
end
