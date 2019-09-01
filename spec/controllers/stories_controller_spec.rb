require 'rails_helper'

RSpec.describe StoriesController, type: :controller do
  describe "GET #new" do
    before do
      @user = create(:user)
      @other_user = create(:other_user)
      @genre = create(:genre)
      @novel = create(:novel, user_id: @user.id, genre_id: @genre.id)
    end

    context "when the requested novel is current_user's novel" do
      before do
        login_user @user
        get :new, params: { novel_id: @novel.id }
      end
      it "assgins the requested story to @story" do
        expect(assigns(:story)).to be_a_new(Story)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end

    context "when the requested novel is not current_user's novel" do
      before do
        login_user @other_user
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
      @other_user = create(:other_user)
      @genre = create(:genre)
      @novel = create(:novel, user_id: @user.id, genre_id: @genre.id)
      @story = attributes_for(:story, novel_id: @novel.id)
      @invalid_story = attributes_for(:invalid_story, novel_id: @novel.id)
    end

    context "when the requested novel is current_user's novel" do
      before do
        login_user @user
      end
      context "when the requested params is valid" do
        it "saves the new novel in the database" do
          expect do
            post :create, params: { novel_id: @novel.id, story: @story }
          end.to change(Story, :count).by(1)
        end

        it "redirects to root_url" do
          post :create, params: { novel_id: @novel.id, story: @story }
          expect(response).to redirect_to @user
        end
      end

      context "when the requested params is invalid" do
        it "renders the new template" do
          post :create, params: { novel_id: @novel.id, story: @invalid_story }
          expect(response).to render_template :new
        end
      end
    end

    context "when the requested novel is not current_user's novel" do
      before do
        login_user @other_user
      end

      it "redirects to root_url" do
        post :create, params: { novel_id: @novel.id, story: @story }
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
      @other_novel = create(:other_novel, user_id: @user.id, genre_id: @genre.id)
      @story = create(:story, novel_id: @novel.id)
    end

    context "when the requested novel is current_user's novel" do
      before do
        login_user @user
      end
      context "when the requested story is the requested novel's story" do
        before do
          get :edit, params: { novel_id: @novel.id, id: @story.id }
        end

        it "assgins the requested story to @story" do
          expect(assigns(:story)).to eq @story
        end
        it "renders the edit template" do
          expect(response).to render_template :edit
        end
      end

      context "when the requested story is not the requested novel's story" do
        before do
          get :edit, params: { novel_id: @other_novel.id, id: @story.id }
        end
        it "redirects to root_url" do
          expect(response).to redirect_to root_url
        end
      end
    end

    context "when the requested novel is not current_user's novel" do
      before do
        # allow(controller)
        # .to receive(:current_user)
        # .and_return(@other_user)
        login_user @other_user
        get :edit, params: { novel_id: @novel.id, id: @story.id }
      end
      it "redirects to root_url" do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "PATCH #update" do
    before do
      @user = create(:user)
      @genre = create(:genre)
      @novel = create(:novel, user_id: @user.id, genre_id: @genre.id)
      @story = create(:story, novel_id: @novel.id)
      @original_story_title = @story.title
    end

    context "when the requested params is valid" do
      before do
        login_user @user
        patch :update, params: { novel_id: @novel.id, id: @story.id, story: attributes_for(:story, title: "update_title") }
      end

      it "updates the novel in the database" do
        @story.reload
        expect(@story.title).to eq "update_title"
      end
    end

    context "when the requested params is invalid" do
      before do
        login_user @user
        patch :update, params: { novel_id: @novel.id, id: @story.id, story: attributes_for(:story, title: " ") }
      end

      it "does not update the novel in the database" do
        @story.reload
        expect(@story.title).to eq @original_story_title
      end
      it "renders the edit template" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "delete #destroy" do
    before do
      @user = create(:user)
      @genre = create(:genre)
      @novel = create(:novel, user_id: @user.id, genre_id: @genre.id)
      @story = create(:story, novel_id: @novel.id)
      login_user @user
    end
    it "destroy the novel in the database" do
      expect do
        delete :destroy, params: { novel_id: @novel.id, id: @story.id, story: @story }
      end.to change(Story, :count).by(-1)
    end

    it "redirects to root_url" do
      delete :destroy, params: { novel_id: @novel.id, id: @story.id, story: @story }
      expect(response).to redirect_to root_url
    end
  end
end
