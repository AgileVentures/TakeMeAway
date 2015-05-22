class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  def authenticate_api_user
    #caller needs to inclde 'email' and 'token' in request headers
    #i e token, 2-pvxogfa5ah8jtoGb7D <- for seeded admin
    email = request.headers['email']
    token = request.headers['token']

    unauthorised unless User.find_for_authentication(email: email, token: token)
  end

private

  def unauthorised
    render json: { message: 'Access Forbidden' }, status: 403
  end
end


