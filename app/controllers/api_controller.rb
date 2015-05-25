class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  attr_accessor :current_user

  #caller needs to inclde 'email' and 'token' in request headers
  #i e 'email: user@tma.org', 'token: 2-pvxogfa5ah8jtoGb7D"
  def authenticate_api_user
    email = request.headers['email']
    token = request.headers['token']

    user = User.find_for_database_authentication(email: email)

    if (user && user.authentication_token == token)
      self.current_user = user
    else
      render_unauthorised
    end
  end

  private

  def render_server_error msg='Server Error'
    render json: {message: msg}, status: 500
  end

  def render_unauthorised msg='Access Forbidden'
    render json: { message: msg }, status: 403
  end
end


