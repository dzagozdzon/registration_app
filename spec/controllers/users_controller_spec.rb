require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe 'GET #new' do
        it 'returns http success' do
          get :new
          expect(response).to have_http_status(:success)
        end
      end

    describe 'POST #create' do
        let(:valid_params) do
          { user:
            { first_name: 'Jurek',
              last_name: 'Brzeczek',
              email: 'jerzybrzeczek@pzpn.pl' } }
        end
    
        let(:invalid_params) do
          { user:
            { first_name: 'Adam',
              last_name: 'Nawalka',
              email: 'LechPoznan' } }
        end

        it 'create user profile with valid params' do
            expect do
                post :create, params: valid_params
            end.to change(User, :count).by(1)
        end

        it 'cannot create user profile with invalid params' do
            expect do 
                post :create, params: invalid_params
            end.to change(User, :count).by(0)
        end

        it 'should redirect to user profile after successfull registration' do
            expect do 
                post :create, params: valid_params

                it { should redirect_to(user_path) }
                it { should redirect_to(action: :show) }
            end
        end

        it 'should render new user path after failed registration' do
            expect do 
                post :create, params: invalid_params 
      
                it { should render_template('new') }
                it { should render_template(partial: '_form') }
            end 
        end
    end
end