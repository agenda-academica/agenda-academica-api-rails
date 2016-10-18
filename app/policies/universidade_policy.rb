class UniversidadePolicy < ApplicationPolicy
  def permitted_attributes
    if create? || update?
      [
        :nome, :abreviacao, :site, :logo
      ]
    else
      []
    end
  end
end
