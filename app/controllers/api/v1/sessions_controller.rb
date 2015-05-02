class Api::V1::SessionsController < ApiController
  # curl http://localhost:3000/v1/sessions --data "email=client@tma.org&password=password"
  # curl http://localhost:3000/v1/sessions --data "email=admin@tma.org&password=password"

  def get_token
    @user = User.find_for_database_authentication(email: params[:email])
    invalid_login_attempt unless @user && @user.valid_password?(params[:password])
  end

  protected

  def invalid_login_attempt
    render json: { message: 'Error with your login or password' }, status: 401
  end


end