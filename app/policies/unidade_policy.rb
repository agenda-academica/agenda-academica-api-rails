class UnidadePolicy < ApplicationPolicy
  def permitted_attributes
    if create? || update?
      [
        :id,
        :universidade_id,
        :nome,
        :endereco,
        :outras_informacoes,
        :unidade_sede
      ]
    else
      []
    end
  end
end
