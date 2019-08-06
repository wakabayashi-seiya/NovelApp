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
  
  
  # describe "GET #edit" do
  #   before do
  #     @user = create(:user)
  #   end
    
  #   context "when current_user is @user"
  #     before do
  #       allow(controller)
  #       .to receive(:current_user)
  #       .and_return(@user)
  #       get :edit, params: { id: @user.id }
  #     end
    
  #     it "renders the edit template" do
  #       expect(response).to render_template :edit    
  #     end
    
  #     it "assigns the requested user to @user" do
  #       expect(assigns(:user)).to eq @user
  #     end
    
  #   context "when current_user is not @user" do
  #     before do
  #       @other_user = create(:other_user)
  #       allow(controller)
  #       .to receive(:current_user)
  #       .and_return(@other_user)
  #     end
      
  #     it "redirects to root_url" do
  #       get :edit, params: { id: @user.id }
  #       expect(response).to redirect_to root_url
  #     end
    
  #   end
  # end
  
  # describe "PATCH #update" do
  #   before do
  #     @user = create(:user)
  #     @original_name = @user.name
  #     @other_user = create(:other_user)
  #   end
  
  #   context "when the requested params is valid" do
  #     before do
  #       allow(controller)
  #       .to receive(:current_user)
  #       .and_return(@user)
  #       patch :update, params: {id: @user.id, user: attributes_for(:user, name: "updated_name") }
  #     end
      
  #     it "updates the user in the databese" do
  #       @user.reload
  #       expect(@user.name).to eq "updated_name"   
  #     end
  #   end
    
  #   context "when the requested params is invalid" do
  #     before do
  #       allow(controller)
  #       .to receive(:current_user)
  #       .and_return(@user)
  #       patch :update, params: {id: @user.id, user: attributes_for(:user, name: " ") }
  #     end
      
  #     it "does not update the user in the database" do
  #       @user.reload
  #       expect(@user.name).to eq @original_name
  #     end
      
  #     it "renders the edit template" do
  #       expect(response).to render_template :edit
  #     end
  #   end
   
  #   context "when current_user is not @user" do
  #     before do
  #       allow(controller)
  #       .to receive(:current_user)
  #       .and_return(@other_user)
  #     end
      
  #     it "redirects to root_url" do
  #       get :update, params: {id: @user.id,  user: attributes_for(:user, name: "updated_name") }
  #       expect(response).to redirect_to root_url
  #     end
  #   end
    
  # end
  
  # describe "DELETE #destroy" do
  #   before do
  #     @user = create(:user)
  #     @other_user = create(:other_user)
  #   end
    
  #   context "when current_user is @user" do
  #     before do
  #       allow(controller)
  #       .to receive(:current_user)
  #       .and_return(@user)
  #     end
  #     it "destroy the requested user in the database" do
  #       expect {
  #         delete :destroy, params: {id: @user.id, user: @user }
  #       }.to change(User, :count).by(-1)
  #     end
    
  #     it "redirects to root_url" do
  #       delete :destroy, params: {id: @user.id, user: @user }
  #       expect(response).to redirect_to root_url
  #     end
  #   end
    
  #   context "when current_user is not @user" do
  #     before do
  #       allow(controller)
  #       .to receive(:current_user)
  #       .and_return(@other_user)
  #     end
  #     it "redirects to root_url" do
  #       delete :destroy, params: {id: @user.id, user: @user }
  #       expect(response).to redirect_to root_url
  #     end
      
  #   end
  # end  
end
