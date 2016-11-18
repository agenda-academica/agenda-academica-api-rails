class RemoveEmailFromTurmas < ActiveRecord::Migration
  def change
    remove_column :turmas, :email
  end
end
