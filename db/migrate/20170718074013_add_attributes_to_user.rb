class AddAttributesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :position, :string
    add_attachment :users, :avatar
    add_column :users, :role, :string
    add_column :users, :birth_date, :datetime
    add_column :users, :gender, :string
    add_column :users, :join_date, :datetime
    add_column :users, :remaining_days_off, :float, default: 0
    add_column :users, :department_id, :integer
    add_column :users, :chatwork_id, :string
    add_column :users, :deleted_at, :integer, default: 0
  end
end
