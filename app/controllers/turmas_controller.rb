class TurmasController < ApplicationController
  respond_to :json
  before_action :load_collection, only: %i[show update destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: %i[]

  def index
    begin
      @turmas = policy_scope(Turma)
      authorize @turmas
      render json: @turmas
        .joins(:universidade)
        .where(universidades: { user_id: current_user.id })
    rescue Exception => e
      Rails.logger.error e
    end
  end

  def show
    render json: @turma
  end

  def create
    @turma = Turma.new(permitted_params)
    authorize @turma
    @turma.save!
    render json: @turma
  end

  def update
    @turma.update!(permitted_params)
    render json: @turma
  end

  def destroy
    id = @turma.id
    disciplinas = @turma.disciplina.ids
    @turma.destroy
    render json: {
      ok: true,
      id: id,
      disciplinas: disciplinas
    }
  end

  private

  def load_collection
    begin
      @turma ||= policy_scope(Turma).find(params[:id])
      authorize @turma
    rescue ActiveRecord::RecordNotFound => e
      skip_authorization
      render json: {
        ok: false,
        message: "Turma ##{params[:id]} doesn't exists."
      }
    end
  end

  def permitted_params
    if params[:turma]
      params
        .require(:turma)
        .permit(*policy(@turma || Turma.new).permitted_attributes)
    else
      {}
    end
  end
end
