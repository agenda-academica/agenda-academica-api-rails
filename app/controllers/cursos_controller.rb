class CursosController < ApplicationController
  respond_to :json
  before_action :load_collection, only: %i[show update destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: %i[]

  def index
    begin
      @cursos = policy_scope(Curso)
      authorize @cursos
      render json: @cursos
        .joins(:universidade)
        .where(universidades: { user_id: current_user.id })
    rescue Exception => e
      Rails.logger.error e
    end
  end

  def show
    render json: @curso
  end

  def create
    @curso = Curso.new(permitted_params)
    authorize @curso
    @curso.save!
    render json: @curso
  end

  def update
    @curso.update!(permitted_params)
    render json: @curso
  end

  def destroy
    id = @curso.id
    turmas = @curso.turma.ids
    disciplinas = @curso.disciplina.ids
    @curso.destroy
    render json: {
      ok: true,
      id: id,
      turmas: turmas,
      disciplinas: disciplinas
    }
  end

  private

  def load_collection
    begin
      @curso ||= policy_scope(Curso).find(params[:id])
      authorize @curso
    rescue ActiveRecord::RecordNotFound => e
      skip_authorization
      render json: {
        ok: false,
        message: "Curso ##{params[:id]} doesn't exists."
      }
    end
  end

  def permitted_params
    if params[:curso]
      params
        .require(:curso)
        .permit(*policy(@curso || Curso.new).permitted_attributes)
    else
      {}
    end
  end
end
