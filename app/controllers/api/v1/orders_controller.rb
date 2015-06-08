class Api::V1::OrdersController < ApiController
  require 'stock_inventory'

  before_action :convert_json_to_params, only: [:create, :update]
  before_action :authenticate_api_user

  # t.integer  "user_id"
  # t.string   "status"
  # t.datetime "order_time"
  # t.datetime "pickup_time"
  # t.datetime "fulfillment_time"
  # t.datetime "created_at",       null: false
  # t.datetime "updated_at",       null: false

  def create
    attributes = order_params.merge(user_id: current_user.id) if current_user
    @order = Order.create(attributes)
    order_items_params.each { |item| add_order_item(item[:menu_id], item[:menu_item], item[:quantity]) }
    invalid_request unless @order.save
  end

  def update
    @order = Order.find(params[:id])
    invalid_request unless make_updates
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def invalid_request
    render json: { message: 'Error' }, status: 401
  end

  def convert_json_to_params
    @json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
  end

  def order_params
    @json_params.require(:order).permit(:status, :order_time, :pickup_time)
  end

  def order_items_params
    @json_params[:order_items]
  end

  def add_order_item(menu_id, menu_item_id, qty)
    @order.order_items.build(menu: Menu.find(menu_id),
                             menu_item: MenuItem.find(menu_item_id),
                             quantity: qty)
    stock_service(menu_id, menu_item_id, -qty)
  end

  def purge_order_items
    @order.order_items.each do |item|
      stock_service(item.menu_id, item.menu_item_id, item.quantity)
    end
    @order.order_items.delete_all
  end

  def stock_service(menu_id, menu_item_id, qty)
    menu_item = MenuItem.find(menu_item_id)
    resource = menu_item.menus.find(menu_id).menu_items_menus.find_by(menu_item_id: menu_item_id)
    if qty < 0
      StockInventory.decrement_inventory(resource, -qty)
    else
      StockInventory.increment_inventory(resource, qty)
    end
  end

  def make_updates
    @order.update_attributes(order_params)
    purge_order_items
    if order_items_params
      order_items_params.each { |item| add_order_item(item[:menu_id], item[:menu_item], item[:quantity]) }
    else
      true
    end
  end
end
