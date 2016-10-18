class CreateDisciplinas < ActiveRecord::Migration
  def change
    create_table :disciplinas do |t|
      t.references :turma, index: true, foreign_key: true
      t.string :abreviacao
      t.string :nome
      t.time :hora_inicio
      t.time :hora_fim
      t.integer :dia_semana

      t.timestamps null: false
    end
  end
end
