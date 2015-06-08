class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session,
  #                      only: proc { |c| c.request.format.json? }

  def access_denied(exception)
    redirect_to new_user_session_path, alert: exception.message
  end
end
