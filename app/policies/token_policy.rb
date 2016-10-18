class TokenPolicy < ApplicationPolicy
  def permitted_attributes
    if create? || update?
      [
        :value
      ]
    else
      []
    end
  end
end
