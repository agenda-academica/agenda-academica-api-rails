class RepresentantesController < ApplicationController
  respond_to :json
  before_action :load_collection, only: %i[show update destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: %i[]

  def index
    begin
      @representantes = policy_scope(Representante)
      authorize @representantes
      render json: @representantes
        .joins(:universidade)
        .where(universidades: { user_id: current_user.id })
    rescue Exception => e
      Rails.logger.error e
    end
  end

  def show
    render json: @representante
  end

  def create
    @representante = Representante.new(permitted_params)
    authorize @representante
    @representante.save!
    render json: @representante
  end

  def update
    @representante.update!(permitted_params)
    render json: @representante
  end

  def destroy
    id = @representante.id
    disciplinas = @representante.disciplina.ids
    @representante.destroy
    render json: {
      ok: true,
      id: id,
      disciplinas: disciplinas
    }
  end

  private

  def load_collection
    begin
      @representante ||= policy_scope(Representante).find(params[:id])
      authorize @representante
    rescue ActiveRecord::RecordNotFound => e
      skip_authorization
      render json: {
        ok: false,
        message: "Representante ##{params[:id]} doesn't exists."
      }
    end
  end

  def permitted_params
    if params[:representante]
      params
        .require(:representante)
        .permit(*policy(@representante || Representante.new).permitted_attributes)
    else
      {}
    end
  end
end
