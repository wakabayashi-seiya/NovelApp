require "rails_helper"

RSpec.describe "Users login", type: :request do
  before do
    @user = create(:user)
  end

  example "invalid login information" do
    get new_user_session_path
    expect(response).to render_template(:new)
    post user_session_path, params: { user: { email: "", password: "" } }
    expect(user_signed_in?).to be_falsey
    expect(response).to render_template(:new)
  end

  example "valid login information" do
    get new_user_session_path
    expect(response).to render_template(:new)
    post user_session_path, params: { user: { email: "example@gmail.com", password: "reaction" } }
    expect(user_signed_in?).to be_truthy
    expect(controller.current_user).to eq(@user)
    expect(response).to redirect_to root_url
    delete destroy_user_session_path
    expect(user_signed_in?).to be_falsey
    expect(response).to redirect_to root_url
  end
end
