require 'rails_helper'

describe Api::V1::OrdersController do

  # t.integer  "user_id"
  # t.string   "status"
  # t.datetime "order_time"
  # t.datetime "pickup_time"
  # t.datetime "fulfillment_time"
  # t.datetime "created_at",       null: false
  # t.datetime "updated_at",       null: false

  let!(:user) { FactoryGirl.create(:user) }

  describe 'POST /v1/orders' do
    before do
      params = {order: {user_id: user.id, status: 'pending', order_time: Time.zone.now, pickup_time: Time.zone.now + 1.hour}}
      post '/v1/orders', params.to_json
    end

    it 'creates an Order instance' do
      puts response_json
      expect(response_json).to eq({'instance' =>
                                       {
                                           'user' => user.id,
                                           'status' => 'pending'
                                       }
                                  })
    end

  end


  describe 'GET /v1/orders/:id' do

  end

  describe 'POST /v1/orders/user/:id' do

  end
end