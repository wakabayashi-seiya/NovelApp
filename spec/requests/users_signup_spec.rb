require "rails_helper"

RSpec.describe "Users signup", type: :request do
  before do
    ActionMailer::Base.deliveries.clear
    @mail_array = ActionMailer::Base.deliveries
  end

  example "valid signup information" do
    get new_user_registration_path
    expect(response).to render_template(:new)
    expect do
      post users_path, params: { user: { name: "tanaka_waka",
                                         email: "example@gmail.com",
                                         password: "reaction",
                                         password_confirmation: "reaction",
                                         field: "head" } }
    end.to change(User, :count).by(1)
    expect(@mail_array.count).to eq(1)
    expect(response).to redirect_to root_url
  end

  example "invalid signup information" do
    expect do
      post users_path, params: { user: { name: "",
                                         email: "",
                                         password: "",
                                         password_confirmation: "",
                                         field: "" } }
    end.not_to change(User, :count)
    expect(@mail_array.count).to eq(0)
    expect(response).to render_template(:new)
  end
end
