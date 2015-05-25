class Api::V1::SessionsController < ApiController
  before_action :authenticate_api_user, only: [:clear_token]

  #login:
  # curl -X POST http://localhost:3000/v1/sessions --data "email=client@tma.org&password=password"
  # curl -X POST http://localhost:3000/v1/sessions --data "email=admin@tma.org&password=password"
  def get_token
    @user = User.find_for_database_authentication(email: params[:email])
    if (@user && @user.valid_password?(params[:password]))
      @user.ensure_authentication_token
    else
      invalid_login_attempt
    end
  end

  #logout:
  # curl -X DELETE http://localhost:3000/v1/sessions -H "email: user@tma.org" -H "token: c-LXmsFavPiCEBRvchxe"
  def clear_token
    if current_user.clear_authentication_token!
      render json: { message: 'Token successfully cleared' }, status: 200
    else
      render_server_error "Token reset failed"
    end
  end

  protected

  def invalid_login_attempt
    render json: { message: 'Email or password is incorrect' }, status: 401
  end


end