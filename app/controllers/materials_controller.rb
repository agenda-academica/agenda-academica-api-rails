class MaterialsController < ApplicationController
  respond_to :json
  before_action :load_collection, only: %i[show update destroy]
  after_action :verify_authorized
  skip_after_action :verify_authorized, only: [:index]
  after_action :verify_policy_scoped, only: %i[]

  def index
    begin
      @materials = policy_scope(Material)
      authorize @materials
      render json: @materials
        .joins(:universidade)
        .where(universidades: { user_id: current_user.id })
    rescue Exception => e
      Rails.logger.error e
    end
  end

  def show
    render json: @material
  end

  def create
    @material = Material.new(permitted_params)
    authorize @material
    @material.save!
    render json: @material
  end

  def update
    @material.update!(permitted_params)
    render json: @material
  end

  def destroy
    id = @material.id
    @material.destroy
    render json: {
      ok: true,
      id: id
    }
  end

  private

  def load_collection
    begin
      @material ||= policy_scope(Material).find(params[:id])
      authorize @material
    rescue ActiveRecord::RecordNotFound => e
      skip_authorization
      render json: {
        ok: false,
        message: "Material ##{params[:id]} doesn't exists."
      }
    end
  end

  def permitted_params
    if params[:material]
      params
        .require(:material)
        .permit(*policy(@material || Material.new).permitted_attributes)
    else
      {}
    end
  end
end
