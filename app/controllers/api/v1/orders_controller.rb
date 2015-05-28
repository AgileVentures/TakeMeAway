class Api::V1::OrdersController < ApiController
  require 'stock_inventory'

  before_action :convert_json_to_params, only: [:create, :update]

  # t.integer  "user_id"
  # t.string   "status"
  # t.datetime "order_time"
  # t.datetime "pickup_time"
  # t.datetime "fulfillment_time"
  # t.datetime "created_at",       null: false
  # t.datetime "updated_at",       null: false

  def create
    attributes = order_params
    @order = Order.create(attributes)
    order_items_params.each { |item| add_order_item(item[:menu_item], item[:quantity]) }
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
    render json: {message: 'Error'}, status: 401
  end

  def convert_json_to_params
    @json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
  end

  def order_params
    @json_params.require(:order).permit(:user_id, :status, :order_time, :pickup_time, :menu_items)
  end

  def order_items_params
    @json_params[:order_items]
  end

  def menu_params
    @json_params[:order][:menu_id]
  end

  def add_order_item(id, qty)
    @order.order_items.create(menu_item: MenuItem.find(id), quantity: qty)
    stock_service(id, qty)
  end

  def purge_order_items
    @order.order_items.delete_all
  end


  def stock_service(menu_item_id, qty)
    menu_item = MenuItem.find(menu_item_id)
    resource = menu_item.menus.find(menu_params).menu_items_menus.find_by(menu_item_id: menu_item_id)
    StockInventory.decrement_inventory(resource, qty)
  end

  def make_updates
    @order.update_attributes(order_params)

    purge_order_items
    unless order_items_params.nil?
      # binding.pry
      order_items_params.each { |item| add_order_item(item[:menu_item], item[:quantity]) }
    else
      true
    end
  end

end
