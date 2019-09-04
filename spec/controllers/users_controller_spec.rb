require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    before do
      @user = create(:user)
    end

    context "when the requested user exists" do
      before do
        get :show, params: { id: @user.id }
      end
      it "renders the show template" do
        expect(response).to render_template :show
      end

      it "assigns the requested user to @user" do
        expect(assigns(:user)).to eq @user
      end
    end
  end
end
