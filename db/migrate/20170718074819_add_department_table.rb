class AddDepartmentTable < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.integer :manager_id
      t.string :name
    end
  end
end
