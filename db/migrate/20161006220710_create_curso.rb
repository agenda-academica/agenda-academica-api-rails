class CreateCurso < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.references :unidade, index: true, foreign_key: true
      t.string :abreviacao
      t.string :nome
      t.string :outras_informacoes

      t.timestamps null: false
    end
  end
end
