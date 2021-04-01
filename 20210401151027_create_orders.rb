class CreateOrders < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.integer :store_id, null:false
      t.datetime :date_created, null:false
      t.datetime :date_closed, null:false
      t.datetime :last_updated, null:false
      t.float :total_amount, null:false
      t.float :total_shipping, null:false
      t.float :total_amount_with_shipping, null:false
      t.float :paid_amount, null:false
	  t.datetime :last_updated, null:false
      t.string :status, null:false
      t.integer :shipping_id, null:false
      t.integer :buyer_id, null:false
      
      # chaves estrangeiras
      t.foreign_key :stores
      t.foreign_key :shippings
      t.foreign_key :buyers
    end unless table_exists?(:orders)
  end

  def down
    drop_table :orders if table_exists?(:orders)
  end
end
