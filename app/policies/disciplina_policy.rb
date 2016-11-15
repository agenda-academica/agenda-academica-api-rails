class DisciplinaPolicy < ApplicationPolicy
  def permitted_attributes
    if create? || update?
      [
        :turma_id,
        :abreviacao,
        :nome,
        :hora_inicio,
        :hora_fim,
        :dia_semana,
        :notify_at
      ]
    else
      []
    end
  end
end
