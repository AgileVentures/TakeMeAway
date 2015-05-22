class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  def authenticate_api_user
    #caller needs to inclde 'email' and 'token' in request headers
    #i e token, 2-pvxogfa5ah8jtoGb7D <- for seeded admin
    email = request.headers['email']
    token = request.headers['token']

    user = User.find_for_database_authentication(email: email)
    unauthorised unless (user && user.authentication_token == token)
  end

private

  def unauthorised
    render json: { message: 'Access Forbidden' }, status: 403
  end
end


