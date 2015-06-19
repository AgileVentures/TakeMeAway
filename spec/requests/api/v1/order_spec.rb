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
  let(:params) do
    {
      order: {
        user_id: user.id,
        # menu_id: menu.id,
        order_time: Time.zone.now,
        pickup_time: Time.zone.now + 1.hour
      },
      order_items: [{ menu_id: menu.id, menu_item: menu_item.id, quantity: 1 }]
    }
  end

  let(:menu_item) { FactoryGirl.create(:menu_item) }
  let(:menu_item2) { FactoryGirl.create(:menu_item, name: 'Second Item', price: 50) }
  let(:menu) { FactoryGirl.create(:menu) }
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    authenticate_user user

    menu.menu_items_menus.create(menu_item: menu_item, daily_stock: 20)
    menu.menu_items_menus.create(menu_item: menu_item2, daily_stock: 20)
    FactoryGirl.create(:kitchen_user)
  end

  describe 'menu.menu_items_menus' do
    it { expect(menu.menu_items_menus.count).to eq 2 }
  end

  describe 'POST /v1/orders' do
    context 'Receives valid query parameters' do
      include EmailSpec::Helpers
      include EmailSpec::Matchers

      it 'creates an Order instance' do
        expect { post '/v1/orders', params.to_json }.to change(Order, :count).by 1
      end

      it 'creates instance of OrderItem' do
        expect { post '/v1/orders', params.to_json }.to change(OrderItem, :count).by 1
      end

      it 'returns a response' do
        post '/v1/orders', params.to_json
        order = Order.first

        expect(response_json).to eq('id' => order.id,
                                    'user' => user.id,
                                    'status' => 'pending',
                                    "pickup_time"=> clean_time(params[:order][:pickup_time]),
                                    "amount" => order.amount.to_s,
                                    'items' =>
                                         [{ 'id' => menu_item.id,
                                            'item' => menu_item.name,
                                            'price' => menu_item.price.to_f }])
      end

      it 'decrements MenuItemMenu by quantity after creating the order' do
        post '/v1/orders', params.to_json

        menu_item_instance = menu.menu_items_menus.find_by(menu_item_id: menu_item.id)
        expect(menu_item_instance.daily_stock).to eq 19
      end

      it 'send notification emails to kitchen and to customer' do
        expect{ post '/v1/orders', params.to_json}.to change(all_emails, :count).by(+2)
      end

    end

    context 'Receives invalid parameters' do
      it 'returns an error message' do
        post '/v1/orders', {
          order: { user_id: user.id, menu_id: menu.id },
          order_items: []
        }.to_json

        expect(response_json).to include('message' => 'Something went wrong')
        expect(response.status).to eq 422
      end
    end
  end

  describe 'GET /v1/orders/:id' do
    before do
      @order = FactoryGirl.create(:order, user_id: user.id, status: 'pending',
                                          order_time: Time.zone.now,
                                          pickup_time: Time.zone.now + 1.hour)
      @order.order_items.create(menu_id: menu.id, menu_item: menu_item, quantity: 1)
    end

    it 'returns Order by id' do
      get "/v1/orders/#{@order.id}"
      order = @order

      expect(response_json).to eq('id' => order.id,
                                  'user' => user.id,
                                  'status' => 'pending',
                                  "pickup_time"=> clean_time(params[:order][:pickup_time]),
                                  "amount" => order.amount.to_s,
                                  'items' =>
                                       [{ 'id' => menu_item.id,
                                          'item' => menu_item.name,
                                          'price' => menu_item.price.to_f }])
    end
  end

  describe 'PATCH /v1/orders/user/:id' do
    before(:each) do
      post '/v1/orders', params.to_json
      @order = Order.first
    end

    it 'changing an item' do
      patch "/v1/orders/#{@order.id}", {
        order: { user_id: user.id }, # , menu_id: menu.id },
        order_items: [{ menu_id: menu.id, menu_item: menu_item.id, quantity: 1 },
                      { menu_id: menu.id, menu_item: menu_item2.id, quantity: 1 }]
      }.to_json
      order = @order

      expect(response_json).to eq('id' => order.id,
                                  'user' => user.id,
                                  'status' => 'pending',
                                  "pickup_time"=> clean_time(params[:order][:pickup_time]),
                                  "amount" => order.amount.to_s,
                                  'items' => [{
                                              'id' => menu_item.id,
                                              'item' => menu_item.name,
                                              'price' => menu_item.price.to_f
                                            }, {
                                              'id' => menu_item2.id,
                                              'item' => 'Second Item',
                                              'price' => 50.0
                                            }])
    end

    it 'decrements MenuItemMenu by quantity' do
      patch "/v1/orders/#{@order.id}", {
        order: { user_id: user.id }, # , menu_id: menu.id },
        order_items: [{ menu_id: menu.id, menu_item: menu_item.id, quantity: 1 },
                      { menu_id: menu.id, menu_item: menu_item2.id, quantity: 1 }]
      }.to_json

      @order.order_items.each do |item|
        menu_item_instance = menu.menu_items_menus.find_by(menu_item_id: item.menu_item_id)
        expect(menu_item_instance.daily_stock).to eq 19
      end
    end

    it 'adding order_item creates new instance of OrderItem' do
      patch "/v1/orders/#{@order.id}", {
        order: { user_id: user.id }, # , menu_id: menu.id },
        order_items: [{ menu_id: menu.id, menu_item: menu_item.id, quantity: 1 },
                      { menu_id: menu.id, menu_item: menu_item2.id, quantity: 1 }]
      }.to_json

      expect { post '/v1/orders', params.to_json }.to change(OrderItem, :count).by 1
    end

    it 'changing an pickup_time' do
      time = (Time.zone.now + 2.hours).strftime('%H:%M:%S')
      json_data = {
        order: { user_id: user.id, menu_id: menu.id, pickup_time: time },
        order_items: [{ menu_id: menu.id, menu_item: menu_item.id, quantity: 1 }]
      }.to_json

      patch "/v1/orders/#{@order.id}", json_data
      order = @order

      expect(response_json).to eq('id' => order.id,
                                  'user' => user.id,
                                  'status' => 'pending',
                                  "pickup_time"=> clean_time(time),
                                  "amount" => order.amount.to_s,
                                  'items' =>
                                       [{ 'id' => menu_item.id,
                                          'item' => menu_item.name,
                                          'price' => menu_item.price.to_f }])
    end

    context 'DELETE - Cancel an Order' do
      before(:each) do
        json_data = { order: {
          user_id: user.id, menu_id: menu.id, status: 'canceled' } }.to_json

        patch "/v1/orders/#{@order.id}", json_data
      end

      it 'set status to \'canceled\'' do
        expect(response_json['status']).to eq 'canceled'
      end

      it 'update the stock accordingly when an order is cancelled' do
        @order.order_items.each do |item|
          menu_item_instance = menu.menu_items_menus.find_by(menu_item_id: item.menu_item_id)
          expect(menu_item_instance.daily_stock).to eq 20
        end
      end
    end
  end
end
