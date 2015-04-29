class Api::V1::MenusController < ApplicationController
  def show
    @menu = Menu.find(params[:id])
  end
end