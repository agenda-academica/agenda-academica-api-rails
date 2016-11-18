class AddRepresentantesToTurmas < ActiveRecord::Migration
  def change
    add_column :turmas, :representantes, :json
  end
end
