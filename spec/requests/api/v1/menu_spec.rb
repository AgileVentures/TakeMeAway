require 'rails_helper'

describe Api::V1::MenusController do
  describe 'GET /v1/menus/:id' do

    before do
      @menus = FactoryGirl.create_list(:menu, 3)
    end

    it 'returns a menu index' do
      get "/v1/menus"
      puts response_json
    end

    it 'returns a menu by :id' do
      menu = @menus[0]
      get "/v1/menus/#{menu.id}"
      expect(response_json).to eq({'menu' =>
                                       {
                                           'id' => menu.id,
                                           'start_date' => menu.start_date.strftime('%F'),
                                           'end_date' => menu.end_date.strftime('%F')
                                       },
                                   'specials' =>
                                       {
                                           'items' => 'no items'
                                       }

                                  })
    end
  end
end

