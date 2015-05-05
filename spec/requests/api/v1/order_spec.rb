require 'rails_helper'

describe Api::V1::OrdersController do

  # t.integer  "user_id"
  # t.string   "status"
  # t.datetime "order_time"
  # t.datetime "pickup_time"
  # t.datetime "fulfillment_time"
  # t.datetime "created_at",       null: false
  # t.datetime "updated_at",       null: false

  let(:user) { FactoryGirl.create(:user) }
  let(:params) { {order: {user_id: user.id, status: 'pending', order_time: Time.zone.now, pickup_time: Time.zone.now + 1.hour}} }
  let(:request) { }

  describe 'POST /v1/orders' do
    it 'creates an Order instance' do
      expect { post '/v1/orders', params.to_json }.to change(Order, :count).by 1
    end

    it 'returns a response' do
      post '/v1/orders', params.to_json
      #puts response_json
      expect(response_json).to eq({'instance' =>
                                       {
                                           'user' => user.id,
                                           'status' => 'pending'
                                       }
                                  })
    end

  end


  describe 'GET /v1/orders/:id' do
    before do
      @order = FactoryGirl.create(:order, user_id: user.id, status: 'pending', order_time: Time.zone.now, pickup_time: Time.zone.now + 1.hour)
    end

    it 'returns Order by id' do
      get "/v1/orders/#{@order.id}"
      expect(response_json).to eq({'instance' =>
                                       {
                                           'user' => user.id,
                                           'status' => 'pending'
                                       }
                                  })
    end


  end

  describe 'POST /v1/orders/user/:id' do

  end
end