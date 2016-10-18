class CreateRepresentantes < ActiveRecord::Migration
  def change
    create_table :representantes do |t|
      t.references :turma, index: true, foreign_key: true
      t.string :nome
      t.string :email

      t.timestamps null: false
    end
  end
end
