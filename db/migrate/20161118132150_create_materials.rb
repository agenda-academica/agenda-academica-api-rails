class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.references :turma, index: true, foreign_key: true
      t.json :anexos
      t.datetime :data_envio

      t.timestamps null: false
    end
  end
end
