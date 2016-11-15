class AddNotifyAtToDisciplinas < ActiveRecord::Migration
  def change
    add_column :disciplinas, :notify_at, :time, null: false, default: '00:15:00'
  end
end
