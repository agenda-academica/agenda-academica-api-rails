class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.references :user, index: true, foreign_key: true
      t.string :value

      t.timestamps null: false
    end
  end
end
