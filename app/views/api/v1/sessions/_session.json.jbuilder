json.cache! user do
  json.user do
    json.email user.email
    if user.admin?
      json.is_admin 'true'
    end
  end

  json.authentication_token do
    json.token user.authentication_token
  end
end