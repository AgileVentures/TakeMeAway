class Api::V1::MenusController < ApiController

  def index
    @menus = Menu.this_week
  end

  def show
    @menu = Menu.find(params[:id])
  end
end
