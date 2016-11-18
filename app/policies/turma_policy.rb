class TurmaPolicy < ApplicationPolicy
  def permitted_attributes
    if create? || update?
      [
        :curso_id,
        :nome,
        :site,
        :outras_informacoes,
        representantes: [
          :nome,
          :sobrenome,
          :email
        ]
      ]
    else
      []
    end
  end
end
