class UnidadesController < ApplicationController
  respond_to :json
  before_action :load_collection, only: %i[show update destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: %i[]

  def index
    begin
      @unidades = policy_scope(Unidade)
      authorize @unidades
      render json: @unidades
        .joins(:universidade)
        .where(universidades: { user_id: current_user.id })
    rescue Exception => e
      Rails.logger.error e
    end
  end

  def show
    render json: @unidade
  end

  def create
    @unidade = Unidade.new(permitted_params)
    authorize @unidade
    @unidade.save!
    render json: @unidade
  end

  def update
    @unidade.update!(permitted_params)
    render json: @unidade
  end

  def destroy
    id = @unidade.id
    cursos = @unidade.curso.ids
    turmas = @unidade.turma.ids
    disciplinas = @unidade.disciplina.ids
    @unidade.destroy
    render json: {
      ok: true,
      id: id,
      cursos: cursos,
      turmas: turmas,
      disciplinas: disciplinas
    }
  end

  private

  def load_collection
    begin
      @unidade ||= policy_scope(Unidade).find(params[:id])
      authorize @unidade
    rescue ActiveRecord::RecordNotFound => e
      skip_authorization
      render json: {
        ok: false,
        message: "Unidade ##{params[:id]} doesn't exists."
      }
    end
  end

  def permitted_params
    if params[:unidade]
      params
        .require(:unidade)
        .permit(*policy(@unidade || Unidade.new).permitted_attributes)
    else
      {}
    end
  end
end
