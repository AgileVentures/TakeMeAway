require 'rails_helper'

describe Api::V1::UsersController do
  let(:user) {FactoryGirl.build(:user)}

  describe "create user: POST /v1/users" do
    it "valid credentials returns user & token" do
      post '/v1/users', "name=#{user.name}&email=#{user.email}&password=#{user.password}&password_confirmation=#{user.password}"

      expect(response.status).to eq 200
      expect(response_json["user"]["name"]).to eq user.name
      expect(response_json["user"]["email"]).to eq user.email
      expect(response_json["authentication_token"]["token"]).to_not be_blank
    end

    it "invalid credentials returns error message" do
      post '/v1/users', "name=#{user.name}&email=#{user.email}&password=#{'12345678'}&&password_confirmation=#{'wrong_confirmation'}"

      expect(response.status).to eq 400
      expect(response_json["message"]).to_not be_blank
    end
  end
end
