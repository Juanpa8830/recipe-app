require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  let(:user) { User.create(name: 'Juan pablo', email: 'juanpa@admin.com', password: '123456') }
  let(:food) { Food.create(name: 'Food 1', measurement_unit: 'kg', price: 76) }

  describe 'GET #index' do
    context 'when user is logged in' do
      before do
        user.confirm
        sign_in user
      end

      it 'returns http success' do
        get :index

        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        get :index

        expect(response).to render_template :index
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get :index

        expect(response).to redirect_to new_user_session_path
      end

      it 'returns http redirect' do
        get :index

        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'GET #new' do
    context 'when user is logged' do
      before do
        user.confirm
        sign_in user
      end

      it 'returns a success response' do
        get :new

        expect(response).to be_successful
      end

      it 'assigns a new Food' do
        get :new

        expect(assigns(:food)).to be_a_new(Food)
      end

      it 'renders the new template' do
        get :new

        expect(response).to render_template(:new)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get :new

        expect(response).to redirect_to new_user_session_path
      end

      it 'returns http redirect' do
        get :new

        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { User.create(name: 'Shahadat Hossain', email: 'test@example.com', password: '12345678') }

    context 'when user is logged in with valid params' do
      let(:valid_params) { { food: { name: 'Test Food', measurement_unit: 'kg', price: 76 } } }

      before do
        user.confirm
        sign_in user
      end

      it 'creates a new Food' do
        expect do
          post :create, params: valid_params
        end.to change(Food, :count).by(1)
      end

      it 'redirects to the Food page' do
        post :create, params: valid_params

        expect(response).to redirect_to(foods_path)
      end

      it 'sets a flash notice' do
        post :create, params: valid_params

        expect(flash[:notice]).to eq('Food was successfully created.')
      end
    end

    context 'when food invalid params' do
      let(:invalid_params) { { food: { name: '' } } }

      before do
        user.confirm
        sign_in user
      end

      it 'does not create a new Food' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Food, :count)
      end

      it 'renders the new template' do
        post :create, params: invalid_params

        expect(response).to render_template(:new)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        post :create, params: { Food: { name: 'Test Food' } }

        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(:redirect)
      end

      it 'does not create a new Food' do
        expect do
          post :create, params: { Food: { name: 'Test Food' } }
        end.not_to change(Food, :count)
      end
    end
  end
end
