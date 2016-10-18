class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.references :disciplina, index: true, foreign_key: true
      t.string :tipo
      t.string :titulo
      t.string :descricao
      t.date :dataInicio
      t.date :dataFim
      t.time :horaInicio
      t.time :horaFim

      t.timestamps null: false
    end
  end
end
