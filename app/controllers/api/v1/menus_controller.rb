class Api::V1::MenusController < ApiController
  before_action :authenticate_api_user, only: [:index]

  def index
    @menus = Menu.this_week
  end

  def show
    @menu = Menu.find(params[:id])
  end
end