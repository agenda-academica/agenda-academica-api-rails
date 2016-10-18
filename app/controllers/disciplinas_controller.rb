class DisciplinasController < ApplicationController
  respond_to :json
  before_action :load_collection, only: %i[show update destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: %i[]

  def index
    begin
      @disciplinas = policy_scope(Disciplina)
      authorize @disciplinas
      render json: @disciplinas
        .joins(:universidade)
        .where(universidades: { user_id: current_user.id })
    rescue Exception => e
      Rails.logger.error e
    end
  end

  def show
    render json: @disciplina
  end

  def create
    @disciplina = Disciplina.new(permitted_params)
    authorize @disciplina
    @disciplina.save!
    render json: @disciplina
  end

  def update
    @disciplina.update!(permitted_params)
    render json: @disciplina
  end

  def destroy
    id = @disciplina.id
    @disciplina.destroy
    render json: {
      ok: true,
      id: id
    }
  end

  private

  def load_collection
    begin
      @disciplina ||= policy_scope(Disciplina).find(params[:id])
      authorize @disciplina
    rescue ActiveRecord::RecordNotFound => e
      skip_authorization
      render json: {
        ok: false,
        message: "Disciplina ##{params[:id]} doesn't exists."
      }
    end
  end

  def permitted_params
    if params[:disciplina]
      params
        .require(:disciplina)
        .permit(*policy(@disciplina || Disciplina.new).permitted_attributes)
    else
      {}
    end
  end
end
