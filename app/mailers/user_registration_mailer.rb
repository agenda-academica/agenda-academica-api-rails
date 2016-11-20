class UserRegistrationMailer < ApplicationMailer
  default :from => 'Agenda Acadêmica <welcome@agendaacademica.com.br>'

  def welcome_email(id)
    @user = load_model id
    mail to: @user.email, subject: "Olá #{@user.first_name}, sinta-se em casa..."
  end

  private

  def load_model(id)
    User.find id
  end
end
