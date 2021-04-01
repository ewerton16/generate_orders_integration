ActiveRecord::Schema.define(version: 20210401151027) do
  # as outras tabelas não estão aqui, pois só usei uma para exemplificar o desenvolvimento

  create_table "orders", force: :cascade do |t|
    t.integer  "maint_order_id",             limit: 4,   null: false
    t.datetime "date_created",                           null: false
    t.datetime "date_closed",                            null: false
    t.datetime "last_updated",                           null: false
    t.float    "total_amount",               limit: 24,  null: false
    t.float    "total_shipping",             limit: 24,  null: false
    t.float    "total_amount_with_shipping", limit: 24,  null: false
    t.float    "paid_amount",                limit: 24,  null: false
    t.string   "status",                     limit: 255, null: false
    t.integer  "maint_plan_id",              limit: 4,   null: false
    t.integer  "general_req_id",             limit: 4,   null: false
  end

  add_foreign_key "orders", "stores", name: "orders_store_id_fk"
  add_foreign_key "orders", "shippings", name: "orders_shipping_id_fk"
  add_foreign_key "orders", "buyers", name: "orders_buyer_id_fk"
end
