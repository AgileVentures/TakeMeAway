json.cache! user do
  json.user do
    json.name user.name
    json.email user.email
    json.is_admin 'true' if user.admin?
  end

  json.authentication_token do
    json.token user.authentication_token
  end
end
