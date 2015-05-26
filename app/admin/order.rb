ActiveAdmin.register Order do
  controller do
    helper :orders

    def show
      params[:order] = Order.find(params[:id])
    end

    def update
      super
    end

    def permitted_params
      params.permit order: [:id, :user_id, :status, :order_time, :pickup_time, :fulfillment_time],
                    order_item: [:id, :order_id, :menu_item_id, :quantity]
      #params.permit!
    end

  end

  scope 'Canceled', :canceled
  scope 'Pending', :pending, default: true
  scope 'Processed', :processed
  scope :all

  actions :all, except: [:destroy]

  member_action :change_status, method: :put do
    if resource.status == 'processed'
      resource.set_status('pending')
      notice = 'Changed status to \'pending\''
    else
      resource.set_status('processed')
      notice = 'Changed status to \'processed\''
    end
    redirect_to admin_orders_path, notice: notice
  end

  member_action :cancel, method: :put do
    resource.set_status('canceled')
    redirect_to admin_orders_path, notice: 'Canceled order'
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

  #permit_params do
  #  permitted = [:user_id, :status, :order_time, :pickup_time, :fulfillment_time, order_item: [:order_id, :menu_item_id, :quantity]]
  #end



index do
  selectable_column
  column 'Order' do |order|
    "Order ##{order.id}"
  end
  column 'User' do |order|
    link_to order.user.name, admin_client_path(order.user_id)
  end
  column :order_time
  column :status do |order|
    status_tag(order.status, status_color(order))
  end
  column 'Order items' do |order|
    (order.order_items.map { |p| p.menu_item.name }).join(', ').html_safe
  end
  actions class: 'btn' do |order|
    [(link_to 'Change status', {action: 'change_status', id: order}, method: :put unless order.status == 'canceled'),
     (link_to 'Cancel', {action: 'cancel', id: order}, method: :put unless order.status == 'canceled')].join(' ').html_safe
  end
end

form do |f|
  f.semantic_errors
  f.inputs 'Order' do
    f.input :user_id, label: 'Client', as: :select, collection: User.all.map { |u| [u.name, u.id] }
    f.input :status, as: :select, collection: Order::STATUS
    f.input :order_time, as: :date_time_picker, datepicker_options: {format: 'Y-m-d H:i'}
    f.input :pickup_time, as: :date_time_picker, datepicker_options: {format: 'Y-m-d H:i'}
    f.input :total
    #f.inputs 'Order Items' do

    #  f.input :order_items, as: :select, input_html: {multiple: true, class: 'custom-select'}
    # end

  end
  f.actions
  render partial: '/admin/orders/order_items_form'
end

show do
  attributes_table do
    row('user') { |order| link_to order.user.name, admin_client_path(order.user_id) }
    row('email') { |order| order.user.email }
    row :status do |order|
      status_tag(order.status, status_color(order))
    end
    row :pickup_time
    h3 'Order Items'
    table_for params[:order].order_items do
      column :name do |item|
        item.menu_item.name
      end
      column :price do |item|
        item.menu_item.price
      end
      column :quantity
    end
  end
end

end



