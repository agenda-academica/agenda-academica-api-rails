class AddTituloToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :titulo, :string
  end
end
