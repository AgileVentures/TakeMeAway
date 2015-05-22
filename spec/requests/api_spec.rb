require 'rails_helper'

describe ApiController, type: :controller do

  class DummyController < ApiController;
    before_action :authenticate_api_user, only: [:private_action]

    def public_action
      render nothing: true
    end

    def private_action
      render nothing: true
    end
  end
  controller DummyController do end

  describe "Api controller actions" do
    let(:user) {FactoryGirl.build_stubbed(:user)}

    before :each do
      routes.draw do
        get 'public_action', to: 'dummy#public_action'
        get 'private_action', to: 'dummy#private_action'
      end
    end

    specify "public actions" do
      expect_any_instance_of(ApiController).to_not receive(:authenticate_api_user)
      get :public_action
    end

    specify "restricted actions require authentication" do
      expect_any_instance_of(ApiController).to receive(:authenticate_api_user)
      get :private_action
    end

    describe "authenticate_api_user method" do
      specify "with correct email and token" do
        request.headers['email'] = user.email
        request.headers['token'] = user.authentication_token
        expect(User).to receive(:find_for_database_authentication).with({email: user.email}).and_return(user)
        get :private_action

        expect(response.status).to eq 200
      end

      specify "with correct email and wrong token" do
        request.headers['email'] = user.email
        request.headers['token'] = ""
        expect(User).to receive(:find_for_database_authentication).with({email: user.email}).and_return(user)
        get :private_action

        expect(response_json["message"]).to_not be_blank
        expect(response.status).to eq 403
      end

      specify "with wrong email and token" do
        request.headers['email'] = ""
        request.headers['token'] = ""
        expect(User).to receive(:find_for_database_authentication).with({email: ""}).and_return(nil)
        get :private_action

        expect(response_json["message"]).to_not be_blank
        expect(response.status).to eq 403
      end
    end
  end
end
