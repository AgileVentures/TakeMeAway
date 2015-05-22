ActiveAdmin.register Order do
  controller do
    helper :orders
  end

  # create_table "orders", force: :cascade do |t|
  #   t.integer  "user_id"
  #   t.string   "status"
  #   t.datetime "order_time"
  #   t.datetime "pickup_time"
  #   t.datetime "fulfillment_time"
  #   t.datetime "created_at",       null: false
  #   t.datetime "updated_at",       null: false
  # end

  permit_params do
    permitted = [:user_id, :status, :order_time, :pickup_time, :fulfillment_time]
    permitted << :total if resource.menu_items.any?
  end

  index do
    selectable_column
    #id_column
    column "user" do |order|
      link_to order.user.name, admin_client_path(order.user_id)
    end
    column :order_time
    column :status do |order|
      status_tag(order.status, status_color(order))
    end
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs 'Order' do
      f.input :user_id, :label => 'Client', as: :select, collection: User.all.map{|u| [u.name, u.id]}
      f.input :status, as: :select, collection: Order::STATUS
      f.input :order_time, as: :date_time_picker, datepicker_options: {format: 'Y-m-d H:i'}
      f.input :pickup_time, as: :date_time_picker, datepicker_options: {format: 'Y-m-d H:i'}
    end
    f.actions
  end


end