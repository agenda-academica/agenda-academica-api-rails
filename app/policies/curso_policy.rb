class CursoPolicy < ApplicationPolicy
  def permitted_attributes
    if create? || update?
      [
        :unidade_id,
        :abreviacao,
        :nome,
        :outras_informacoes
      ]
    else
      []
    end
  end
end
