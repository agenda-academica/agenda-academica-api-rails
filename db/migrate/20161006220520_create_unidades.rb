class CreateUnidades < ActiveRecord::Migration
  def change
    create_table :unidades do |t|
      t.references :universidade, index: true, foreign_key: true
      t.string :nome
      t.string :endereco
      t.string :outras_informacoes
      t.string :unidade_sede

      t.timestamps null: false
    end
  end
end
