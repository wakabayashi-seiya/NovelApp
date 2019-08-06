require 'rails_helper'

RSpec.describe NovelsController, type: :controller do
  
  describe "GET #new" do
    before do
      @user = create(:user)
      @genre = create(:genre)
      # @novel = attributes_for(:novel, user_id: @user.id, genre_id: @genre.id)
    end  
    
    context "when logged in user" do
      before do
        login_user @user
        get :new
      end
      it "assgins the requested novel to @novel" do
        expect(assigns(:novel)).to be_a_new(Novel)
      end
      
      it "renders the new template" do
        expect(response).to render_template :new
      end
    end
    
    context "when not logged in user" do
      before do
        get :new
      end
      it "redirects to root_url" do
        expect(response).to redirect_to root_url
      end
    end
  end
  
  
  describe "POST #create" do
    before do
      @user = create(:user)
      @genre = create(:genre)
      @novel = attributes_for(:novel, user_id: @user.id, genre_id: @genre.id )
      @invalid_novel = attributes_for(:invalid_novel, user_id: @user.id, genre_id: @genre.id)
    end
    
    context "when logged in user" do
      before do
        login_user @user
      end
      context "when the requested params is valid" do
        it "saves the new novel in the database" do
          expect {
            post :create, params: { novel: @novel }  
          }.to change(Novel, :count).by(1)
        end
        
        it "redirects to root_url" do
          post :create, params: { novel: @novel }
          expect(response).to redirect_to root_url
        end
      end
      
      context "when the requested params is invalid" do
        it "renders the new template" do
          post :create, params: { novel: @invalid_novel }
          expect(response).to render_template :new
        end
      end
    end
    
    context "when not logged in user" do
      it "redirects to root_url" do
        post :create, params: { novel: @novel }
        expect(response).to redirect_to root_url
      end
    end
  end
  
  describe "GET #edit" do
    before do
      @user = create(:user)
      @other_user = create(:other_user)
      @genre = create(:genre)
      @novel = create(:novel, user_id: @user.id, genre_id: @genre.id)
      @other_user_novel = create(:other_novel, user_id: @other_user.id, genre_id: @genre.id)
    end
    
    context "when logged in user" do
      before do
        login_user @user
      end
      context "when the requested novel is current_user's novel" do
        before do
          get :edit, params: { id: @novel.id }
        end
        
        it "assgins the requested novel to @novel" do
          expect(assigns(:novel)).to eq @novel
        end
        it "renders the edit template" do
          expect(response).to render_template :edit
        end
      end
      
      context "when the requested novel is not current_user's novel" do
        before do
          get :edit, params: { id: @other_user_novel.id }
        end
        it "redirects to root_url" do
          expect(response).to redirect_to root_url
        end
      end
    end
    
    context "when not logged in user" do
      before do
        get :edit, params: { id: @novel.id }
      end
      it "redirects to root_url" do
        expect(response).to redirect_to root_url
      end
    end
  end
  
  describe "PATCH #update" do
    before do
      @user = create(:user)
      @other_user = create(:other_user)
      @genre = create(:genre)
      @novel = create(:novel, user_id: @user.id, genre_id: @genre.id)
      @original_title = @novel.title
      @other_user_novel = create(:other_novel, user_id: @other_user.id, genre_id: @genre.id)
    end
    
    context "when the requested novel is current_user's novel" do
      before do
       login_user @user
      end
      
      context "when the requested params is valid" do
        before do
          patch :update, params: { id: @novel.id, novel: attributes_for(:novel, title: "update_title") }
        end
      
        it "updates the novel in the database" do
          @novel.reload
          expect(@novel.title).to eq "update_title"
        end
      end
    
      context "when the requested params is invalid" do
        before do
          patch :update, params: { id: @novel.id, novel: attributes_for(:novel, title: " ") }
        end
      
        it "does not update the novel in the database" do
          @novel.reload
          expect(@novel.title).to eq @original_title
        end
        it "renders the edit template" do
          expect(response).to render_template :edit
        end
      end
    end

    context "when the requested novel is not current_user's novel" do
      before do
         login_user @other_user
         patch :update, params: { id: @novel.id, novel: attributes_for(:novel, title: "update_title") }
      end
      it "redirects to root_url" do
        expect(response).to redirect_to root_url
      end
    end
  end
  
  describe "delete #destroy" do
    before do
      @user = create(:user)
      @other_user = create(:other_user)
      @genre = create(:genre)
      @novel = create(:novel, user_id: @user.id, genre_id: @genre.id)
      @original_title = @novel.title
      @other_user_novel = create(:other_novel, user_id: @other_user.id, genre_id: @genre.id)
    end
    
    context "when the requested novel is current_user's novel" do
      before do
        login_user @user
      end
      
      it "destroy the novel in the database" do
        expect {
          delete :destroy, params: { id: @novel.id, novel: @novel }
        }.to change(Novel, :count).by(-1)
      end
      
      it "redirects to root_url" do
        delete :destroy, params: { id: @novel.id, novel: @novel }
        expect(response).to redirect_to root_url
      end
    end
    
    context "when the requested novel is not current_user's novel" do
      before do
        login_user @other_user
      end
      
      it "does not destroy the novel in the database" do
        expect {
          delete :destroy, params: { id: @novel.id, novel: @novel }
        }.not_to change(Novel, :count)
      end
      
      it "redirects to root_url" do
        delete :destroy, params: { id: @novel.id, novel: @novel }
        expect(response).to redirect_to root_url
      end
    end
    
  end
  
  
end