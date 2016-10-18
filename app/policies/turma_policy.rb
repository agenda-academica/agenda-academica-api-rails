class TurmaPolicy < ApplicationPolicy
  def permitted_attributes
    if create? || update?
      [
        :curso_id,
        :nome,
        :email,
        :site,
        :outras_informacoes
      ]
    else
      []
    end
  end
end
