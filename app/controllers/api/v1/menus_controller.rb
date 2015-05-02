class Api::V1::MenusController < ApiController
  before_action :authenticate_api_app

  def index
    @menus = Menu.all
  end

  def show
    @menu = Menu.find(params[:id])
  end
end