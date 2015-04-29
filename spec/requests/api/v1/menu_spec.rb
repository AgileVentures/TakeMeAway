require 'rails_helper'

describe Api::V1::MenusController do
  describe 'GET /v1/menus/:id' do

    before do
      @menu = FactoryGirl.create(:menu)
    end

    it 'returns a menu by :id' do
      menu = @menu
      get "/v1/menus/#{menu.id}"
      expect(response_json).to eq({'menu' =>
                                       {
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

