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

    specify "public actions do not require authentication" do
      expect_any_instance_of(ApiController).to_not receive(:authenticate_api_user)
      expect_any_instance_of(DummyController).to receive(:public_action).and_call_original
      get :public_action
    end

    specify "restricted actions require authentication" do
      expect_any_instance_of(ApiController).to receive(:authenticate_api_user).and_call_original
      expect_any_instance_of(DummyController).to_not receive(:private_action)
      get :private_action
    end

    it "should have a 'current_user' getter and setter" do
      expect(DummyController.instance_methods).to include(:current_user, :current_user=)
    end

    describe "authenticate_api_user method" do
      it "should be defined" do
        expect(DummyController.instance_methods).to include(:authenticate_api_user)
      end

      specify "with correct token" do
        request.headers['token'] = user.authentication_token
        expect(User).to receive(:find_for_database_authentication).with({authentication_token: user.authentication_token}).and_return(user)
        get :private_action

        expect(response.status).to eq 200
        expect(assigns(:current_user)).to eq user
      end

      specify "with correct wrong token" do
        request.headers['token'] = "fake"
        expect(User).to receive(:find_for_database_authentication).with({authentication_token: "fake"}).and_return(nil)
        get :private_action

        expect(response_json["message"]).to_not be_blank
        expect(response.status).to eq 403
        expect(assigns(:current_user)).to eq nil
      end

    end

    describe "render_server_error method" do
      it "should be defined" do
        expect(DummyController.private_instance_methods).to include(:render_server_error)
      end

      it "should call render with message and status" do
        expect_any_instance_of(DummyController).to receive(:render).with(json: {message: "Error test"}, status: 500)

        DummyController.new.send(:render_server_error, "Error test")
      end
    end

    describe "render_unauthorised" do
      it "should be defined" do
        expect(DummyController.private_instance_methods).to include(:render_unauthorised)
      end

      it "should call render with message and status" do
        expect_any_instance_of(DummyController).to receive(:render).with(json: { message: 'Access Forbidden' }, status: 403)

        DummyController.new.send(:render_unauthorised)
      end
    end
  end
end
