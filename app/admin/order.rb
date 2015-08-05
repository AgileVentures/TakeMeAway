ActiveAdmin.register Order do

  controller do
    helper :orders
  end

  permit_params :id, :user_id, :status, :order_time, :pickup_time, :fulfillment_time,
    order_items_attributes: [:id, :menu_id, :menu_item_id, :quantity, :_destroy]

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
      if not Menu.today.empty?
        f.has_many :order_items, 
                      heading: 'Items in this order:',
                      new_record: 'Add Item',
                      allow_destroy: true do |item_form|
          item_form.input :menu, collection: Menu.today, include_blank: false
          item_form.input :menu_item, collection: Menu.today[0].menu_items, 
                          include_blank: false
          item_form.input :quantity, as: :number
        end
      else
        render inline: 'There are no menu items available today - add items to menu(s)'
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row('user') { link_to order.user.name, admin_client_path(order.user_id) }
      row('email') { order.user.email }
      row :status do
        status_tag(order.status, status_color(order))
      end
      row :pickup_time
      h3 'Order Items'
      table_for order.order_items do
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



