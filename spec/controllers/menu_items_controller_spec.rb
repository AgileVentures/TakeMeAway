require 'rails_helper'
include ActionView::Helpers::FormTagHelper
include ActionView::Helpers::FormOptionsHelper

RSpec.describe MenuItemsController, :type => :controller do
  render_views

  let(:menu) { FactoryGirl.create(:menu_with_item) }

  context 'Routing' do
    it 'routes /menu_items/show/:order_item_id/:menu_id to menu_items#show' do
      expect(get: '/menu_items/show/0/10').to route_to(
            controller: 'menu_items', action: 'show', 
            order_item_id: '0', menu_id: '10')
    end
  end
  context 'AJAX fetch of menu items' do
    before do
      xhr :get, :show, order_item_id: 0, menu_id: menu.id
    end
    it 'assigns items for specified menu to @menu_items' do
      expect(assigns(:menu_items)).to eq menu.menu_items
    end
    it 'renders partial to create HTML text' do
      expect(response).to render_template(:_menu_items)
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it 'returns menu_item HTML select element' do
      expect(response.body).to eq select_tag("order[order_items_attributes][0][menu_item_id]",
          options_from_collection_for_select(menu.menu_items, 'id', 'name'))
    end
  end
end
