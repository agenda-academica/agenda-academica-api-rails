class UniversidadesController < ApplicationController
  respond_to :json
  before_action :load_collection, only: %i[show update destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: %i[]

  def index
    begin
      @universidades = policy_scope(Universidade)
      authorize @universidades
      render json: @universidades.where(user_id: current_user.id)
    rescue Exception => e
      Rails.logger.error e
    end
  end

  def show
    render json: @universidade
  end

  def create
    @universidade = Universidade.new(universidade_params)
    @universidade.user = current_user
    authorize @universidade
    @universidade.save!
    render json: @universidade
  end

  def update
    @universidade.update!(universidade_params)
    render json: @universidade
  end

  def destroy
    id = @universidade.id
    unidades = @universidade.unidade.ids
    cursos = @universidade.curso.ids
    turmas = @universidade.turma.ids
    disciplinas = @universidade.disciplina.ids
    @universidade.destroy!
    render json: {
      ok: true,
      id: id,
      unidades: unidades,
      cursos: cursos,
      turmas: turmas,
      disciplinas: disciplinas
    }
  end

  private

  def load_collection
    begin
      @universidade ||= policy_scope(Universidade).find(params[:id])
      authorize @universidade
    rescue ActiveRecord::RecordNotFound => e
      skip_authorization
      render json: {
        ok: false,
        message: "Universidade ##{params[:id]} doesn't exists."
      }
    end
  end

  def universidade_params
    if params[:universidade]
      params
        .require(:universidade)
        .permit(*policy(@universidade || Universidade.new).permitted_attributes)
    else
      {}
    end
  end
end
