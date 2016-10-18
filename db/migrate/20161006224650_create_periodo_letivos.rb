class CreatePeriodoLetivos < ActiveRecord::Migration
  def change
    create_table :periodo_letivos do |t|
      t.references :universidade, index: true, foreign_key: true
      t.string :titulo
      t.datetime :data_inicio
      t.datetime :data_fim
      t.string :cor

      t.timestamps null: false
    end
  end
end
