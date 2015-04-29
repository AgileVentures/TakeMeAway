require 'rails_helper'

# create_table "menus", force: :cascade do |t|
#   t.boolean  "show_category"
#   t.datetime "start_date"
#   t.datetime "end_date"
#   t.datetime "created_at",    null: false
#   t.datetime "updated_at",    null: false

describe 'GET /v1/menus/:id' do
  it 'returns a menu by :id' do
    menu = FactoryGirl.create(:menu)
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