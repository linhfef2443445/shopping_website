class AddColumnToAdmin < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :user_name, :string
    add_column :admins, :role, :integer
  end
end
