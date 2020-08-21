class AddSubtotalToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :subtotal, :decimal, :precision => 15, :scale => 10
  end
end
