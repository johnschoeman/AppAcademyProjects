require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe "GET #show" do
    # it "returns http success" do
    #   get :show
    #   expect(response).to have_http_status(:success)
    #   expect(response).to render_template(:show)
    # end
    it "renders the show template" do
      User.create!(username: 'bob', password: 'password')
      user = User.find_by(username: 'bob')
      user_id = user.id
      get :show, params: {id: user_id}

      expect(response).to render_template(:show)
    end

    context "if the user does not exist" do
      it 'is not a success' do
        begin
          get :show, params: { id: -1 }
        rescue
          ActiveRecord::RecordNotFound
        end

        expect(response).to_not render_template(:show)
      end
    end
  end

  describe "GET #create" do
    # it "returns http success" do
    #   get :create
    #   expect(response).to have_http_status(:success)
    # end
    context "with invalid params" do
      it "renders the new template" do
        post :create, params: { user: { username: 'steve' } }
        expect(response).to render_template(:new)
      end
    end

    context "with vaild parmas" do
      it "redirects to the user's page" do
        post :create, params: { user: { username: 'steve', password: 'password'} }

        expect(response).to redirect_to(user_url(User.find_by(username: 'steve')))

      end
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

end
