class CreateTurma < ActiveRecord::Migration
  def change
    create_table :turmas do |t|
      t.references :curso, index: true, foreign_key: true
      t.string :nome
      t.string :email
      t.string :site
      t.string :outras_informacoes

      t.timestamps null: false
    end
  end
end
