class EventoPolicy < ApplicationPolicy
  def permitted_attributes
    if create? || update?
      [
        :disciplina_id,
        :titulo,
        :descricao,
        :tipo,
        :cor,
        :data_inicio,
        :data_fim,
        :hora_inicio,
        :hora_fim,
        :notify_at
      ]
    else
      []
    end
  end
end
