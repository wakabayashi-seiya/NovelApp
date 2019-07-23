require "rails_helper"

RSpec.describe "Users signup", type: :request do
  before do
    ActionMailer::Base.deliveries.clear
    @mail_array = ActionMailer::Base.deliveries
  end
  
  example "valid signup information" do
    get new_user_path
    expect {
      post users_path, params: { user: { name:  "tanaka_waka",
                                         email: "example@gmail.com", 
                                         password: "reaction",
                                         password_confirmation: "reaction",
                                         field: "head"} } 
      }.to change(User, :count).by(1)
    expect(@mail_array.count).to eq(1)
    expect(response).to redirect_to root_url
    user = assigns(:user)
    post login_path, params: { session: { email: "example@gmail.com", password: "reaction" } }
    expect(is_logged_in?).to be_falsey
    get edit_account_activation_path(user.activation_token, email: user.email)
    expect(is_logged_in?).to be_truthy
  end
  
  example "invalid signup information" do
    get new_user_path
    expect {
      post users_path, params: { user: { name: "",
                                         email: "",
                                         password: "",
                                         password: "",
                                         field: "" } }
    }.not_to change(User, :count)
    expect(@mail_array.count).to eq(0)
    expect(response).to render_template :new
  end
  
end