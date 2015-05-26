module Authenticate

  # authenticates an user for testing restricted controllers actions
  def authenticate_user user
    allow_any_instance_of(ApiController).to receive(:authenticate_api_user).and_return(true)
    allow_any_instance_of(ApiController).to receive(:current_user).and_return(user)
  end
end
