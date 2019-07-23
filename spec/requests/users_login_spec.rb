require "rails_helper"

RSpec.describe "Users login", type: :request do
  before do
    @user = create(:user)
  end
  
  example "invalid login information" do
    get login_path
    expect(response).to render_template("sessions/new")
    post login_path, params: { session: { email: "", password: "" } }
    expect(flash[:danger]).not_to be_empty
    expect(response).to render_template("sessions/new")
  end
  
  example "valid login information" do
    get login_path
    expect(response).to render_template("sessions/new")
    post login_path, params: { session: { email: "example@gmail.com", password: "reaction" } }
    expect(is_logged_in?).to be_truthy
    expect(response).to redirect_to root_url
    delete logout_path
    expect(is_logged_in?).to be_falsey
    expect(response).to redirect_to root_url
  end
  
  
end
