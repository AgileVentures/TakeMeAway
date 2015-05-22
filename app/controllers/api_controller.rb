class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  attr_accessor :current_user

  def authenticate_api_user
    #caller needs to inclde 'email' and 'token' in request headers
    #i e token, 2-pvxogfa5ah8jtoGb7D <- for seeded admin
    email = request.headers['email']
    token = request.headers['token']

    user = User.find_for_database_authentication(email: email)
    render_unauthorised unless (user && user.authentication_token == token)
    self.current_user = user
  end

  def render_server_error msg='Server Error'
    render json: {message: msg}, status: 500
  end

private

  def render_unauthorised
    render json: { message: 'Access Forbidden' }, status: 403
  end
end


