require 'rails_helper'

describe Api::V1::SessionsController do
  describe 'POST /v1/sessions' do

    before do
      @admin = FactoryGirl.create(:user, is_admin: true)
      @user = FactoryGirl.create(:user)
    end

    describe 'admin login' do
      it 'valid credentials returns user & token' do
        post '/v1/sessions', "email=#{@admin.email}&password=#{@admin.password}"
        expect(response_json).to eq({'user' => {
                                        'email' => @admin.email,
                                        'is_admin' => "#{@admin.is_admin}"
                                    },
                                     'authentication_token' => {
                                         'token' => @admin.authentication_token
                                     }
                                    })
      end

      it 'invalid password returns error message' do
        post '/v1/sessions', "email=#{@admin.email}&password=bogus"
        expect(response_json).to eq({ 'message' => 'Email or password is incorrect' })
        expect(response.status).to eq 401
      end

      it 'invalid email returns error message' do
        post '/v1/sessions', "email=bogus&password=#{@admin.password}"
        expect(response_json).to eq({ 'message' => 'Email or password is incorrect' })
        expect(response.status).to eq 401
      end

    end

    describe 'client login' do
      it 'valid credentials returns user & token' do
        post '/v1/sessions', "email=#{@user.email}&password=#{@user.password}"
        expect(response_json).to eq({'user' => {
                                        'email' => @user.email
                                    },
                                     'authentication_token' => {
                                         'token' => @user.authentication_token
                                     }
                                    })
      end

      it 'invalid password returns error message' do
        post '/v1/sessions', "email=#{@user.email}&password=bogus"
        expect(response_json).to eq({ 'message' => 'Email or password is incorrect' })
        expect(response.status).to eq 401
      end

      it 'invalid email returns error message' do
        post '/v1/sessions', "email=bogus&password=#{@user.password}"
        expect(response_json).to eq({ 'message' => 'Email or password is incorrect' })
        expect(response.status).to eq 401
      end

    end

    describe 'reset_token method' do
      before :each do
        expect_any_instance_of(ApiController).to receive(:authenticate_api_user).and_return(true)
        expect_any_instance_of(ApiController).to receive(:current_user).and_return(@user)
      end

      it "successfull" do
        old_token = @user.authentication_token
        delete '/v1/sessions'
        @user.reload

        expect(response.status).to eq 200
        expect(old_token).to_not eq @user.authentication_token
      end

      it "unsuccessful" do
        expect(@user).to receive(:reset_authentication_token!).and_return(false)
        delete '/v1/sessions'

        expect(response.status).to eq 500
      end


    end
  end

end
