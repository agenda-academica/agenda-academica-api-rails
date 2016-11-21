class MaterialMailer < ApplicationMailer
  default :from => 'Agenda Acadêmica <material@agendaacademica.com.br>'

  def share_email_to_representante(id, representante_index)
    @material = load_model id
    @representante = @material.turma.representantes[representante_index]
    @user = @material.user
    mail to: @representante['email'], subject: @material.titulo
  end

  private

  def load_model(id)
    Material.find id
  end
end
