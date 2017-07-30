class CreateRequestOffs < ActiveRecord::Migration[5.1]
  def change
    create_table :request_offs do |t|
      t.datetime :time_start
      t.datetime :time_end
      t.float :total_hours
      t.text :reason
      t.text :comment
      t.string :status, default: 'waiting'
      t.datetime :status_update_at
      t.integer :status_update_by
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
