class MaterialPolicy < ApplicationPolicy
  def permitted_attributes
    if create? || update?
      [
        :turma_id,
        :titulo,
        :data_envio,
        anexos: [
          :titulo,
          :material_url,
        ],
      ]
    else
      []
    end
  end
end
