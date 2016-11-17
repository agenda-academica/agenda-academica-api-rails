class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.references :disciplina, index: true, foreign_key: true
      t.string :tipo
      t.string :cor
      t.string :titulo
      t.string :descricao
      t.date :data_inicio
      t.date :data_fim
      t.time :hora_inicio
      t.time :hora_fim
      t.time :notify_at, null: false, default: '00:15:00'

      t.timestamps null: false
    end
  end
end
