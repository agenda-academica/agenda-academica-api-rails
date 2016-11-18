class RegistrationsController < DeviseTokenAuth::RegistrationsController
  def update()
    current_user.update(permitted_params)
    render json: current_user
  end

  def permitted_params
    params.permit(:first_name, :last_name, :avatar, :password)
  end
end
