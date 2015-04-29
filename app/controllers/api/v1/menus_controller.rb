class Api::V1::MenusController < ApiController
  def show
    @menu = Menu.find(params[:id])
  end
end