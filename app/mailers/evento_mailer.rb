class EventoMailer < ApplicationMailer
  default :from => 'Agenda Acadêmica <eventos@agendaacademica.com.br>'

  def notify_representantes_email(id, representante_index)
    @evento = load_model id
    @representante = @evento.turma.representantes[representante_index]
    @user = @evento.user
    mail to: @representante['email'], subject: "@ professor(a) #{@user.first_name} criou um novo evento!"
  end

  private

  def load_model(id)
    Evento.find id
  end
end
