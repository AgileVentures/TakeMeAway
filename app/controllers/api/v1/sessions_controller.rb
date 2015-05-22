class Api::V1::SessionsController < ApiController
  before_action :authenticate_api_user, only: [:reset_token]
  # curl http://localhost:3000/v1/sessions --data "email=client@tma.org&password=password"
  # curl http://localhost:3000/v1/sessions --data "email=admin@tma.org&password=password"

  def get_token
    @user = User.find_for_database_authentication(email: params[:email])
    invalid_login_attempt unless @user && @user.valid_password?(params[:password])
  end

  def reset_token
    if self.current_user.reset_authentication_token!
      render json: { message: 'Token successfuly reset' }, status: 200
    else
      render_server_error "Token reset failed"
    end
  end

  protected

  def invalid_login_attempt
    render json: { message: 'Email or password is incorrect' }, status: 401
  end


end