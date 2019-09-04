require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe "GET #new" do
    before do
      @user = create(:user)
      @genre = create(:genre)
      @novel = create(:novel, user_id: @user.id, genre_id: @genre.id)
    end

    context "when logged in user" do
      before do
        login_user @user
        get :new, params: { novel_id: @novel.id }
      end
      it "assgins the requested review to @review" do
        expect(assigns(:review)).to be_a_new(Review)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end

    context "when not logged in user" do
      before do
        get :new, params: { novel_id: @novel.id }
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
      @novel = create(:novel, user_id: @user.id, genre_id: @genre.id)
      @review = attributes_for(:review, user_id: @user.id, novel_id: @novel.id)
      @invalid_review = attributes_for(:invalid_review, user_id: @user.id, novel_id: @novel.id)
    end

    context "when logged in user" do
      before do
        login_user @user
      end
      context "when the requested params is valid" do
        it "saves the new review in the database" do
          expect do
            post :create, params: { novel_id: @novel.id, review: @review }
          end.to change(Review, :count).by(1)
        end

        it "redirects to the review novel's page" do
          post :create, params: { novel_id: @novel.id, review: @review }
          expect(response).to redirect_to @novel
        end
      end

      context "when the requested params is invalid" do
        it "renders the new template" do
          post :create, params: { novel_id: @novel.id, review: @invalid_review }
          expect(response).to render_template :new
        end
      end
    end

    context "when not logged in user" do
      it "redirects to root_url" do
        post :create, params: { novel_id: @novel.id, review: @review }
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
      @review = create(:review, user_id: @user.id, novel_id: @novel.id)
      @other_user_review = create(:other_review, user_id: @other_user.id, novel_id: @novel.id)
    end

    context "when logged in user" do
      before do
        login_user @user
      end
      context "when the requested review is current_user's review" do
        before do
          get :edit, params: { novel_id: @novel.id, id: @review.id }
        end

        it "assgins the requested review to @review" do
          expect(assigns(:review)).to eq @review
        end
        it "renders the edit template" do
          expect(response).to render_template :edit
        end
      end

      context "when the requested review is not current_user's review" do
        before do
          get :edit, params: { novel_id: @novel.id, id: @other_user_review.id }
        end
        it "redirects to root_url" do
          expect(response).to redirect_to root_url
        end
      end
    end

    context "when not logged in user" do
      before do
        get :edit, params: { novel_id: @novel.id, id: @review.id }
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
      @review = create(:review, user_id: @user.id, novel_id: @novel.id)
      @other_user_review = create(:other_review, user_id: @other_user.id, novel_id: @novel.id)
      @original_title = @review.title
    end

    context "when the requested review is current_user's review" do
      before do
        login_user @user
      end

      context "when the requested params is valid" do
        before do
          patch :update, params: { novel_id: @novel.id, id: @review.id, review: attributes_for(:review, title: "update_title") }
        end

        it "updates the review in the database" do
          @review.reload
          expect(@review.title).to eq "update_title"
        end
        
        it "redirects to the review novel's page" do
          expect(response).to redirect_to @novel
        end
      end

      context "when the requested params is invalid" do
        before do
          patch :update, params: { novel_id: @novel.id, id: @review.id, review: attributes_for(:review, title: " ") }
        end

        it "does not update the review in the database" do
          @review.reload
          expect(@review.title).to eq @original_title
        end
        it "renders the edit template" do
          expect(response).to render_template :edit
        end
      end
    end

    context "when the requested review is not current_user's review" do
      before do
        login_user @other_user
        patch :update, params: { novel_id: @novel.id, id: @review.id, review: attributes_for(:review, title: "update_title") }
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
      @review = create(:review, user_id: @user.id, novel_id: @novel.id)
    end

    context "when the requested review is current_user's review" do
      before do
        login_user @user
      end

      it "destroy the review in the database" do
        expect do
          delete :destroy, params: { novel_id: @novel.id, id: @review.id, review: @review }
        end.to change(Review, :count).by(-1)
      end

      it "redirects to root_url" do
        delete :destroy, params: { novel_id: @novel.id, id: @review.id, review: @review }
        expect(response).to redirect_to root_url
      end
    end

    context "when the requested review is not current_user's review" do
      before do
        login_user @other_user
      end

      it "does not destroy the review in the database" do
        expect do
          delete :destroy, params: { novel_id: @novel.id, id: @review.id, review: @review }
        end.not_to change(Review, :count)
      end

      it "redirects to root_url" do
        delete :destroy, params: { novel_id: @novel.id, id: @review.id, review: @review }
        expect(response).to redirect_to root_url
      end
    end
  end
end
