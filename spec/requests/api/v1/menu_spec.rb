require 'rails_helper'

describe Api::V1::MenusController do
  describe 'GET /v1/menus/:id' do
    before do
      Timecop.freeze(Date.parse('2015-05-06').at_beginning_of_week)
      @menus = FactoryGirl.create_list(:menu, 3)
      @menu_items = FactoryGirl.create_list(:menu_item, 3)
      @menus.each do |menu|
        @menu_items.each do |menu_item|
          menu.menu_items_menus.create(menu_item: menu_item, daily_stock: 20)
        end
      end

      allow_any_instance_of(MenuItem).to receive_message_chain(:image, :path) { "v1/1.jpg" }
    end

    after do
      Timecop.return
    end

    it 'returns a menu index' do
      get '/v1/menus'
      puts puts JSON.pretty_generate(response_json)

      expect(response_json).to eq('date_range' => '2015-05-04..2015-05-10',
                                  'menus' => [{
                                                  'id' => @menus[0].id,
                                                  'title' => @menus[0].title,
                                                  'start_date' => @menus[0].start_date.strftime('%F'),
                                                  'end_date' => @menus[0].end_date.strftime('%F'),
                                                  'uri' => "http://www.example.com/v1/menus/#{@menus[0].id}",
                                                  'item_count' => 3,
                                                  'items' => [
                                                      {
                                                          'id' => @menu_items[0].id,
                                                          'status' => 'active',
                                                          'name' => @menu_items[0].name,
                                                          'price' => @menu_items[0].price.to_f.to_s,
                                                          'description' => @menu_items[0].description,
                                                          'ingredients' => @menu_items[0].ingredients,
                                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                                      },
                                                      {
                                                          'id' => @menu_items[1].id,
                                                          'status' => 'active',
                                                          'name' => @menu_items[1].name,
                                                          'price' => @menu_items[1].price.to_f.to_s,
                                                          'description' => @menu_items[1].description,
                                                          'ingredients' => @menu_items[1].ingredients,
                                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                                      },
                                                      {
                                                          'id' => @menu_items[2].id,
                                                          'status' => 'active',
                                                          'name' => @menu_items[2].name,
                                                          'price' => @menu_items[2].price.to_f.to_s,
                                                          'description' => @menu_items[2].description,
                                                          'ingredients' => @menu_items[2].ingredients,
                                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                                      }
                                                  ]
                                              }, {
                                                  'id' => @menus[1].id,
                                                  'title' => @menus[1].title,
                                                  'start_date' => @menus[1].start_date.strftime('%F'),
                                                  'end_date' => @menus[1].end_date.strftime('%F'),
                                                  'uri' => "http://www.example.com/v1/menus/#{@menus[1].id}",
                                                  'item_count' => 3,
                                                  'items' => [
                                                      {
                                                          'id' => @menu_items[0].id,
                                                          'status' => 'active',
                                                          'name' => @menu_items[0].name,
                                                          'price' => @menu_items[0].price.to_f.to_s,
                                                          'description' => @menu_items[0].description,
                                                          'ingredients' => @menu_items[0].ingredients,
                                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                                      },
                                                      {
                                                          'id' => @menu_items[1].id,
                                                          'status' => 'active',
                                                          'name' => @menu_items[1].name,
                                                          'price' => @menu_items[1].price.to_f.to_s,
                                                          'description' => @menu_items[1].description,
                                                          'ingredients' => @menu_items[1].ingredients,
                                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                                      },
                                                      {
                                                          'id' => @menu_items[2].id,
                                                          'status' => 'active',
                                                          'name' => @menu_items[2].name,
                                                          'price' => @menu_items[2].price.to_f.to_s,
                                                          'description' => @menu_items[2].description,
                                                          'ingredients' => @menu_items[2].ingredients,
                                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                                      }
                                                  ]
                                              }, {
                                                  'id' => @menus[2].id,
                                                  'title' => @menus[2].title,
                                                  'start_date' => @menus[2].start_date.strftime('%F'),
                                                  'end_date' => @menus[2].end_date.strftime('%F'),
                                                  'uri' => "http://www.example.com/v1/menus/#{@menus[2].id}",
                                                  'item_count' => 3,
                                                  'items' => [
                                                      {
                                                          'id' => @menu_items[0].id,
                                                          'status' => 'active',
                                                          'name' => @menu_items[0].name,
                                                          'price' => @menu_items[0].price.to_f.to_s,
                                                          'description' => @menu_items[0].description,
                                                          'ingredients' => @menu_items[0].ingredients,
                                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                                      },
                                                      {
                                                          'id' => @menu_items[1].id,
                                                          'status' => 'active',
                                                          'name' => @menu_items[1].name,
                                                          'price' => @menu_items[1].price.to_f.to_s,
                                                          'description' => @menu_items[1].description,
                                                          'ingredients' => @menu_items[1].ingredients,
                                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                                      },
                                                      {
                                                          'id' => @menu_items[2].id,
                                                          'status' => 'active',
                                                          'name' => @menu_items[2].name,
                                                          'price' => @menu_items[2].price.to_f.to_s,
                                                          'description' => @menu_items[2].description,
                                                          'ingredients' => @menu_items[2].ingredients,
                                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                                      }
                                                  ]
                                              }])
    end

    it 'returns inactive status on menu_items without stock' do
      @menus[0].menu_items_menus.find(@menu_items[0].id).update_attribute(:daily_stock, 0)
      puts @menus[0].menu_items_menus.find(@menu_items[0].id).menu_item.name
      puts @menus[0].menu_items_menus.find(@menu_items[0].id).menu_item.id
      binding.pry
      get '/v1/menus'
      expect(response_json['menus']).to include ({
                                                  'id' => @menus[0].id,
                                                  'title' => @menus[0].title,
                                                  'start_date' => @menus[0].start_date.strftime('%F'),
                                                  'end_date' => @menus[0].end_date.strftime('%F'),
                                                  'uri' => "http://www.example.com/v1/menus/#{@menus[0].id}",
                                                  'item_count' => 3,
                                                  'items' => [
                                                      {
                                                          'id' => @menu_items[0].id,
                                                          'status' => 'active',
                                                          'name' => @menu_items[0].name,
                                                          'price' => @menu_items[0].price.to_f.to_s,
                                                          'description' => @menu_items[0].description,
                                                          'ingredients' => @menu_items[0].ingredients,
                                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                                      },
                                                      {
                                                          'id' => @menu_items[1].id,
                                                          'status' => 'inactive',
                                                          'name' => @menu_items[1].name,
                                                          'price' => @menu_items[1].price.to_f.to_s,
                                                          'description' => @menu_items[1].description,
                                                          'ingredients' => @menu_items[1].ingredients,
                                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                                      },
                                                      {
                                                          'id' => @menu_items[2].id,
                                                          'status' => 'active',
                                                          'name' => @menu_items[2].name,
                                                          'price' => @menu_items[2].price.to_f.to_s,
                                                          'description' => @menu_items[2].description,
                                                          'ingredients' => @menu_items[2].ingredients,
                                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                                      }
                                                  ]
                                              }  )

    end

    it 'returns a menu by :id' do
      menu = @menus[0]
      get "/v1/menus/#{menu.id}"
      expect(response_json).to eq('id' => @menus[0].id,
                                  'title' => @menus[0].title,
                                  'start_date' => @menus[0].start_date.strftime('%F'),
                                  'end_date' => @menus[0].end_date.strftime('%F'),
                                  'uri' => "http://www.example.com/v1/menus/#{@menus[0].id}",
                                  'item_count' => 3,
                                  'items' => [
                                      {
                                          'id' => @menu_items[0].id,
                                          'status' => 'active',
                                          'name' => @menu_items[0].name,
                                          'price' => @menu_items[0].price.to_f.to_s,
                                          'description' => @menu_items[0].description,
                                          'ingredients' => @menu_items[0].ingredients,
                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                      }, {
                                          'id' => @menu_items[1].id,
                                          'status' => 'active',
                                          'name' => @menu_items[1].name,
                                          'price' => @menu_items[1].price.to_f.to_s,
                                          'description' => @menu_items[1].description,
                                          'ingredients' => @menu_items[1].ingredients,
                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                      }, {
                                          'id' => @menu_items[2].id,
                                          'status' => 'active',
                                          'name' => @menu_items[2].name,
                                          'price' => @menu_items[2].price.to_f.to_s,
                                          'description' => @menu_items[2].description,
                                          'ingredients' => @menu_items[2].ingredients,
                                          'image_medium' => 'http://res.cloudinary.com/sample/image/upload/c_fit,h_300,w_300/v1/1.jpg',
                                          'image_thumb' => 'http://res.cloudinary.com/sample/image/upload/c_thumb,h_100,w_100/v1/1.jpg'
                                      }
                                  ]
                               )
    end
  end
end
