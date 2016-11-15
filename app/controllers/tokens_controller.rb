require 'exponent-server-sdk'

class TokensController < ApplicationController
  after_action :verify_authorized, except: %i[create send_test_notification]
  after_action :verify_policy_scoped, only: %i[]

  def create
    unless Token.where(user: current_user).first
      @token = Token.new(token_params)
      @token.user = current_user
      @token.save!
    end

    render json: { success: true }
  end

  def send_test_notification
    @user = User.where(email: params[:email]).first
    @token = Token.where(user: @user).first

    exponent.publish(
      exponentPushToken: @token.value,
      message: params[:message],
      data: { foo: 'bar' },
    )

    render json: { success: true }
  end

  private

  def token_params
    if params[:token]
      params
        .require(:token)
        .permit(*policy(@token || Token.new).permitted_attributes)
    else
      {}
    end
  end

  def exponent
    @exponent ||= Exponent::Push::Client.new
  end
end
