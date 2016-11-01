require 'exponent-server-sdk'

class TokensController < ApplicationController
  after_action :verify_authorized
  after_action :verify_authorized, except: %i[send_test_notification]
  after_action :verify_policy_scoped, only: %i[]

  def create
    @token = Token.new(token_params)
    @token.user = current_user
    @token.save!

    render json: { success: true }
  end

  def send_test_notification
    @token = Token.where(user: current_user).first

    exponent.publish(
      exponentPushToken: @token.value,
      message: 'Send Push Notification Test',
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
