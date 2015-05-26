require 'rails_helper'
include ApplicationHelper

describe Api::V1::OrdersController do

  # t.integer  "user_id"
  # t.string   "status"
  # t.datetime "order_time"
  # t.datetime "pickup_time"
  # t.datetime "fulfillment_time"
  # t.datetime "created_at",       null: false
  # t.datetime "updated_at",       null: false

  let(:user) { FactoryGirl.create(:user) }
  let(:params) { {order:
                      {user_id: user.id,
                       order_time: Time.zone.now,
                       pickup_time: Time.zone.now + 1.hour,
                      },
                  order_items: [{menu_item: menu_item.id, quantity: 1}]} }
  let(:menu_item) { FactoryGirl.create(:menu_item) }
  let(:menu_item2) { FactoryGirl.create(:menu_item, name: 'Second Item', price: 50) }

  describe 'POST /v1/orders' do
    it 'creates an Order instance' do
      expect { post '/v1/orders', params.to_json }.to change(Order, :count).by 1
    end

    it 'creates instance of OrderItem' do
      expect { post '/v1/orders', params.to_json }.to change(OrderItem, :count).by 1
    end

    it 'returns a response' do
      post '/v1/orders', params.to_json
      expect(response_json).to eq({'user' => user.id,
                                   'status' => 'pending',
                                   'items' =>
                                       [{'id' => menu_item.id,
                                         'item' => menu_item.name,
                                         'price' => menu_item.price.to_f}]
                                  })
    end

  end


  describe 'GET /v1/orders/:id' do
    before do
      @order = FactoryGirl.create(:order, user_id: user.id, status: 'pending', order_time: Time.zone.now, pickup_time: Time.zone.now + 1.hour)
      @order.order_items.create(menu_item:menu_item, quantity: 1)
    end

    it 'returns Order by id' do
      get "/v1/orders/#{@order.id}"
      expect(response_json).to eq({'user' => user.id,
                                   'status' => 'pending',
                                   'items' =>
                                       [{'id' => menu_item.id,
                                         'item' => menu_item.name,
                                         'price' => menu_item.price.to_f}]
                                  }
                               )
    end


  end

  describe 'PATCH /v1/orders/user/:id' do
    before do
      @order = FactoryGirl.create(:order, user_id: user.id, status: 'pending', order_time: Time.zone.now, pickup_time: Time.zone.now + 1.hour)
      @order.order_items.create(menu_item:menu_item, quantity: 1)

    end

    it 'changing an item' do
      patch "/v1/orders/#{@order.id}", {order: {user_id: user.id}, order_items: [{menu_item: menu_item.id, quantity: 1}, {menu_item: menu_item2.id, quantity: 1} ]}.to_json
      expect(response_json.except('pickup_time')).to eq({'user' => user.id,
                                                         'status' => 'pending',
                                                         'items' => [{'id' => menu_item.id,
                                                                      'item' => menu_item.name,
                                                                      'price' => menu_item.price.to_f},
                                                                     {'id' => menu_item2.id,
                                                                      'item' => 'Second Item',
                                                                      'price' => 50.0}]}
                                                     )
    end

    it 'adding order_item creates new instance of OrderItem' do
      patch "/v1/orders/#{@order.id}", {order: {user_id: user.id},
                                        order_items:
                                            [{menu_item: menu_item.id, quantity: 1},
                                             {menu_item: menu_item2.id, quantity: 1}
                                            ]}.to_json

      expect { post '/v1/orders', params.to_json }.to change(OrderItem, :count).by 1
    end

    it 'changing an pickup_time' do
      time = (Time.now + 2.hours).strftime('%H:%M:%S')
      json_data = {order: {user_id: user.id, pickup_time: time},
                   order_items:
                       [{menu_item: menu_item.id, quantity: 1}]
      }.to_json

      patch "/v1/orders/#{@order.id}", json_data
      expect(response_json).to eq({'user' => user.id,
                                   'status' => 'pending',
                                   'pickup_time' => "#{time}",
                                   'items' => [{
                                                   'id' => menu_item.id,
                                                   'item' => menu_item.name,
                                                   'price' => menu_item.price.to_f
                                               }]
                                  })
    end

    it 'DELETE order set status to \'canceled\'' do
      json_data = {order: {user_id: user.id, status: 'canceled'}
      }.to_json

      patch "/v1/orders/#{@order.id}", json_data
      expect(response_json['status']).to eq 'canceled'
    end

  end
end