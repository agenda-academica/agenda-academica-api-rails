class CreateUniversidades < ActiveRecord::Migration
  def change
    create_table :universidades do |t|
      t.references :user, index: true, foreign_key: true
      t.string :nome
      t.string :abreviacao
      t.string :site
      t.string :logo

      t.timestamps null: false
    end
  end
end
