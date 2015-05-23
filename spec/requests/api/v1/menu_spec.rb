require 'rails_helper'

describe Api::V1::MenusController do
  describe 'GET /v1/menus/:id' do
    before do
      Timecop.freeze(Date.parse('2015-05-06').at_beginning_of_week)
      @menus = FactoryGirl.create_list(:menu, 3)
      @menu_items = FactoryGirl.create_list(:menu_item, 3)
      @menus.each do |menu|
        @menu_items.each do |menu_item|
          menu.menu_items << menu_item
        end
      end
    end

    after do
      Timecop.return
    end

    it 'returns a menu index' do
      get '/v1/menus'
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
                                        'name' => @menu_items[0].name,
                                        'price' => @menu_items[0].price.to_f.to_s,
                                        'description' => @menu_items[0].description,
                                        'ingredients' => @menu_items[0].ingredients
                                      },
                                      {
                                        'id' => @menu_items[1].id,
                                        'name' => @menu_items[1].name,
                                        'price' => @menu_items[1].price.to_f.to_s,
                                        'description' => @menu_items[1].description,
                                        'ingredients' => @menu_items[1].ingredients
                                      },
                                      {
                                        'id' => @menu_items[2].id,
                                        'name' => @menu_items[2].name,
                                        'price' => @menu_items[2].price.to_f.to_s,
                                        'description' => @menu_items[2].description,
                                        'ingredients' => @menu_items[2].ingredients
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
                                        'name' => @menu_items[0].name,
                                        'price' => @menu_items[0].price.to_f.to_s,
                                        'description' => @menu_items[0].description,
                                        'ingredients' => @menu_items[0].ingredients
                                      },
                                      {
                                        'id' => @menu_items[1].id,
                                        'name' => @menu_items[1].name,
                                        'price' => @menu_items[1].price.to_f.to_s,
                                        'description' => @menu_items[1].description,
                                        'ingredients' => @menu_items[1].ingredients
                                      },
                                      {
                                        'id' => @menu_items[2].id,
                                        'name' => @menu_items[2].name,
                                        'price' => @menu_items[2].price.to_f.to_s,
                                        'description' => @menu_items[2].description,
                                        'ingredients' => @menu_items[2].ingredients
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
                                        'name' => @menu_items[0].name,
                                        'price' => @menu_items[0].price.to_f.to_s,
                                        'description' => @menu_items[0].description,
                                        'ingredients' => @menu_items[0].ingredients
                                      },
                                      {
                                        'id' => @menu_items[1].id,
                                        'name' => @menu_items[1].name,
                                        'price' => @menu_items[1].price.to_f.to_s,
                                        'description' => @menu_items[1].description,
                                        'ingredients' => @menu_items[1].ingredients
                                      },
                                      {
                                        'id' => @menu_items[2].id,
                                        'name' => @menu_items[2].name,
                                        'price' => @menu_items[2].price.to_f.to_s,
                                        'description' => @menu_items[2].description,
                                        'ingredients' => @menu_items[2].ingredients
                                      }
                                    ]
                                  }])
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
                                      'name' => @menu_items[0].name,
                                      'price' => @menu_items[0].price.to_f.to_s,
                                      'description' => @menu_items[0].description,
                                      'ingredients' => @menu_items[0].ingredients
                                    }, {
                                      'id' => @menu_items[1].id,
                                      'name' => @menu_items[1].name,
                                      'price' => @menu_items[1].price.to_f.to_s,
                                      'description' => @menu_items[1].description,
                                      'ingredients' => @menu_items[1].ingredients
                                    }, {
                                      'id' => @menu_items[2].id,
                                      'name' => @menu_items[2].name,
                                      'price' => @menu_items[2].price.to_f.to_s,
                                      'description' => @menu_items[2].description,
                                      'ingredients' => @menu_items[2].ingredients
                                    }
                                  ]
                                 )
    end
  end
end
