class Api::V1::OrdersController < ApiController

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
    invalid_request unless @order.save
  end


  def update

  end

  def index

  end

  def show

  end

  private

  def invalid_request
    render json: {message: 'Error'}, status: 401
  end

  def order_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
    json_params.require(:order).permit(:user_id, :status, :order_time, :pickup_time)
  end


end