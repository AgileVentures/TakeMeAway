class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  attr_accessor :current_user

  #caller needs to inclde 'token' in request headers
  #i e 'token: 2-pvxogfa5ah8jtoGb7D"
  def authenticate_api_user
    token = request.headers['token']
    user = User.find_for_database_authentication(authentication_token: token)

    if user
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


