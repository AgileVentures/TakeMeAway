require 'rails_helper'

describe Api::V1::SessionsController do
  describe 'POST /v1/sessions' do
    before do
      @admin = FactoryGirl.create(:user, is_admin: true)
      @user = FactoryGirl.create(:user)
    end

    describe 'admin login: get_token action' do
      it 'valid credentials returns user & token' do
        post '/v1/sessions', "email=#{@admin.email}&password=#{@admin.password}"

        expect(response_json).to eq('user' => {
                                      'name' => @admin.name,
                                      'email' => @admin.email,
                                      'is_admin' => "#{@admin.is_admin}"
                                    },
                                    'authentication_token' => {
                                      'token' => @admin.authentication_token
                                    })
        expect(@admin.authentication_token).to_not be nil
      end

      it 'invalid password returns error message' do
        post '/v1/sessions', "email=#{@admin.email}&password=bogus"
        expect(response_json).to eq('message' => 'Email or password is incorrect')
        expect(response.status).to eq 401
      end

      it 'invalid email returns error message' do
        post '/v1/sessions', "email=bogus&password=#{@admin.password}"
        expect(response_json).to eq('message' => 'Email or password is incorrect')
        expect(response.status).to eq 401
      end
    end

    describe 'client login: get_token action' do
      it 'valid credentials returns user & token' do
        post '/v1/sessions', "email=#{@user.email}&password=#{@user.password}"

        expect(response_json).to eq('user' => {
                                      'name' => @user.name,
                                      'email' => @user.email
                                    },
                                    'authentication_token' => {
                                      'token' => @user.authentication_token
                                    })
        expect(@user.authentication_token).to_not be nil
      end

      it 'invalid password returns error message' do
        post '/v1/sessions', "email=#{@user.email}&password=bogus"
        expect(response_json).to eq('message' => 'Email or password is incorrect')
        expect(response.status).to eq 401
      end

      it 'invalid email returns error message' do
        post '/v1/sessions', "email=bogus&password=#{@user.password}"
        expect(response_json).to eq('message' => 'Email or password is incorrect')
        expect(response.status).to eq 401
      end
    end

    describe 'logout: clear_token action' do
      before :each do
        authenticate_user @user
      end

      it 'is successful' do
        delete '/v1/sessions'
        @user.reload

        expect(response.status).to eq 200
        expect(response_json['message']).to_not be nil
        expect(@user.authentication_token).to be nil
      end

      it 'is unsuccessful' do
        expect(@user).to receive(:clear_authentication_token!).and_return(false)
        delete '/v1/sessions'

        expect(response.status).to eq 500
        expect(response_json['message']).to_not be nil
      end
    end
  end
end
