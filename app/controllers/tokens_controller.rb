require 'exponent-server-sdk'

class TokensController < ApplicationController
  after_action :verify_authorized, except: %i[create]
  after_action :verify_policy_scoped, only: %i[]

  def create
    # You probably actually want to associate this with a user,
    # otherwise it's not particularly useful
    @token = Token.where(value: params[:token][:value]).first

    message = ''
    if @token.present?
      message = 'Welcome back!'
    else
      # @token = Token.create(token_params)
      # authorize @token
      message = 'Welcome to Exponent'
    end

    exponent.publish(
      exponentPushToken: params[:token][:value],
      message: message,
      data: {a: 'b'}, # Any arbitrary data to include with the notification
    )

    render json: {success: true}
  end

  private

  def token_params
    params.require(:token).permit(:token)
  end

  def exponent
    @exponent ||= Exponent::Push::Client.new
  end
end

# class TokensController < ApplicationController
#   respond_to :json
  # before_action :load_collection, only: %i[show update destroy]
  # after_action :verify_authorized
  # after_action :verify_policy_scoped, only: %i[]

  # def index
  #   begin
  #     @universidades = policy_scope(Universidade)
  #     authorize @universidades
  #     render json: @universidades.where(user_id: current_user.id)
  #   rescue Exception => e
  #     Rails.logger.error e
  #   end
  # end

  # def show
  #   render json: @universidade
  # end

  # def create
  #   binding.pry
  #   render json: { foo: 'bar' }
  # end

  # def update
  #   @universidade.update!(universidade_params)
  #   render json: @universidade
  # end

  # def destroy
  #   id = @universidade.id
  #   unidades = @universidade.unidade.ids
  #   cursos = @universidade.curso.ids
  #   turmas = @universidade.turma.ids
  #   disciplinas = @universidade.disciplina.ids
  #   @universidade.destroy!
  #   render json: {
  #     ok: true,
  #     id: id,
  #     unidades: unidades,
  #     cursos: cursos,
  #     turmas: turmas,
  #     disciplinas: disciplinas
  #   }
  # end

  # private

  # def load_collection
  #   begin
  #     @universidade ||= policy_scope(Universidade).find(params[:id])
  #     authorize @universidade
  #   rescue ActiveRecord::RecordNotFound => e
  #     skip_authorization
  #     render json: {
  #       ok: false,
  #       message: "Universidade ##{params[:id]} doesn't exists."
  #     }
  #   end
  # end

  # def universidade_params
  #   if params[:universidade]
  #     params
  #       .require(:universidade)
  #       .permit(*policy(@universidade || Universidade.new).permitted_attributes)
  #   else
  #     {}
  #   end
  # end
# end
