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
  let(:params) { {order:
                      {user_id: user.id,
                       status: 'pending',
                       order_time: Time.zone.now,
                       pickup_time: Time.zone.now + 1.hour,
                      },
                  menu_items: [menu_item.id]} }
  let(:menu_item) { FactoryGirl.create(:menu_item) }
  let(:menu_item2) { FactoryGirl.create(:menu_item, name: 'Second Item', price: 50) }

  describe 'POST /v1/orders' do
    it 'creates an Order instance' do
      #binding.pry
      expect { post '/v1/orders', params.to_json }.to change(Order, :count).by 1
    end

    it 'returns a response' do
      post '/v1/orders', params.to_json
      #puts response_json
      expect(response_json).to eq({'instance' =>
                                       {
                                           'user' => user.id,
                                           'status' => 'pending',
                                           'items' =>
                                               [{'id' => menu_item.id,
                                                'item' => menu_item.name,
                                                'price' => menu_item.price.to_f}]
                                       }
                                  })
    end

  end


  describe 'GET /v1/orders/:id' do
    before do
      @order = FactoryGirl.create(:order, user_id: user.id, status: 'pending', order_time: Time.zone.now, pickup_time: Time.zone.now + 1.hour)
      @order.menu_items << menu_item
    end

    it 'returns Order by id' do
      get "/v1/orders/#{@order.id}"
      expect(response_json).to eq({'instance' =>
                                       {
                                           'user' => user.id,
                                           'status' => 'pending',
                                           'items' =>
                                               [{'id' => menu_item.id,
                                                'item' => menu_item.name,
                                                'price' => menu_item.price.to_f}]
                                       }
                                  })
    end


  end

  describe 'PATCH /v1/orders/user/:id' do
    before do
      @order = FactoryGirl.create(:order, user_id: user.id, status: 'pending', order_time: Time.zone.now, pickup_time: Time.zone.now + 1.hour)
      @order.menu_items << menu_item

    end

    it 'changing an item' do
      patch "/v1/orders/#{@order.id}", {order: {user_id: user.id}, menu_items: [menu_item2.id]}.to_json
      puts response_json
      expect(response_json).to eq(
                                   {'instance'=>{"user"=>user.id, "status"=>"pending", "items"=>[{"id"=>menu_item2.id, "item"=>"Second Item", "price"=>50.0}]}}
                               )
    end

    it 'changing an pickup_time' do

      patch "/v1/orders/#{@order.id}", {order: {user_id: user.id, pickup_time: Time.zone.now + 2.hours}, menu_items: [menu_item.id]}.to_json
      puts response_json
       binding.pry
      expect(response_json).to eq(
                                   {'instance'=>{"user"=>user.id, "status"=>"pending", "pickup_time"=> Time.zone.now + 2.hours, "items"=>[{"id"=>menu_item.id, "item"=>menu_item.name, "price"=>menu_item.price.to_f}]}}
                               )
    end

  end
end