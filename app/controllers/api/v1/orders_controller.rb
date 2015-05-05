class Api::V1::OrdersController < ApiController
  before_action :convert_json_to_params, only: [:create]

  # t.integer  "user_id"
  # t.string   "status"
  # t.datetime "order_time"
  # t.datetime "pickup_time"
  # t.datetime "fulfillment_time"
  # t.datetime "created_at",       null: false
  # t.datetime "updated_at",       null: false

  def create
    attributes = order_params
    #binding.pry
    @order = Order.create(attributes)
    order_items_params.each { |item| add_order_item(item) }
    invalid_request unless @order.save
  end


  def update

  end

  def index

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
    @json_params[:menu_items]
  end

  def add_order_item(id)
    @order.menu_items << MenuItem.find(id)
  end


end