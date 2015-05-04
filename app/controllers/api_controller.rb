class ApiController < ApplicationController
  protect_from_forgery with: :null_session


  def authenticate_api_user
    #caller needs to inclde 'token' in request headers
    #i e token, 2-pvxogfa5ah8jtoGb7D <- for seeded admin
    token = request.headers['token']
    false unless User.find_by_authentication_token(token)
  end

  def authenticate_api_app

  end
end