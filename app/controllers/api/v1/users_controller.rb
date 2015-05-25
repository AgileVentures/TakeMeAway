class Api::V1::UsersController < ApiController
# curl -X POST http://localhost:3000/v1/users --data "name=John&email=user@tma.org&password=password&password_confirmation=password"

  def create
    @user = User.new
    @user.attributes = params_permit
    if !@user.save
      render json: { message: @user.errors.full_messages }, status: 400
    end
  end

private

  def params_permit
    params.permit(:name, :email, :password, :password_confirmation)
  end
end