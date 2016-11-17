class EventosController < ApplicationController
  respond_to :json
  before_action :load_collection, only: %i[show update destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: %i[]

  def index
    begin
      @eventos = policy_scope(Evento)
      authorize @eventos
      render json: @eventos
        .joins(:universidade)
        .where(universidades: { user_id: current_user.id })
    rescue Exception => e
      Rails.logger.error e
    end
  end

  def show
    render json: @evento
  end

  def create
    @evento = Evento.new(permitted_params)
    authorize @evento
    @evento.save!
    render json: @evento
  end

  def update
    @evento.update!(permitted_params)
    render json: @evento
  end

  def destroy
    id = @evento.id
    @evento.destroy
    render json: {
      ok: true,
      id: id
    }
  end

  private

  def load_collection
    begin
      @evento ||= policy_scope(Evento).find(params[:id])
      authorize @evento
    rescue ActiveRecord::RecordNotFound => e
      skip_authorization
      render json: {
        ok: false,
        message: "Evento ##{params[:id]} doesn't exists."
      }
    end
  end

  def permitted_params
    if params[:evento]
      params
        .require(:evento)
        .permit(*policy(@evento || Evento.new).permitted_attributes)
    else
      {}
    end
  end
end
