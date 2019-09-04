require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  describe "GET #new" do
    before do
      @user = create(:user)
    end

    context "when logged in user" do
      before do
        login_user @user
        get :new
      end
      it "assgins the requested note to @note" do
        expect(assigns(:note)).to be_a_new(Note)
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
      @note = attributes_for(:note, user_id: @user.id)
      @invalid_note = attributes_for(:invalid_note, user_id: @user.id)
    end

    context "when logged in user" do
      before do
        login_user @user
      end
      context "when the requested params is valid" do
        it "saves the new note in the database" do
          expect do
            post :create, params: { note: @note }
          end.to change(Note, :count).by(1)
        end

        it "redirects to root_url" do
          post :create, params: { note: @note }
          expect(response).to redirect_to root_url
        end
      end

      context "when the requested params is invalid" do
        it "renders the new template" do
          post :create, params: { note: @invalid_note }
          expect(response).to render_template :new
        end
      end
    end

    context "when not logged in user" do
      it "redirects to root_url" do
        post :create, params: { note: @note }
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #edit" do
    before do
      @user = create(:user)
      @other_user = create(:other_user)
      @note = create(:note, user_id: @user.id)
      @other_user_note = create(:other_note, user_id: @other_user.id)
    end

    context "when logged in user" do
      before do
        login_user @user
      end
      context "when the requested note is current_user's note" do
        before do
          get :edit, params: { id: @note.id }
        end

        it "assgins the requested note to @note" do
          expect(assigns(:note)).to eq @note
        end
        it "renders the edit template" do
          expect(response).to render_template :edit
        end
      end

      context "when the requested note is not current_user's note" do
        before do
          get :edit, params: { id: @other_user_note.id }
        end
        it "redirects to root_url" do
          expect(response).to redirect_to root_url
        end
      end
    end

    context "when not logged in user" do
      before do
        get :edit, params: { id: @note.id }
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
      @note = create(:note, user_id: @user.id)
      @original_title = @note.title
    end

    context "when the requested note is current_user's note" do
      before do
        login_user @user
      end

      context "when the requested params is valid" do
        before do
          patch :update, params: { id: @note.id, note: attributes_for(:note, title: "update_title") }
        end

        it "updates the note in the database" do
          @note.reload
          expect(@note.title).to eq "update_title"
        end
      end

      context "when the requested params is invalid" do
        before do
          patch :update, params: { id: @note.id, note: attributes_for(:note, title: " ") }
        end

        it "does not update the note in the database" do
          @note.reload
          expect(@note.title).to eq @original_title
        end
        it "renders the edit template" do
          expect(response).to render_template :edit
        end
      end
    end

    context "when the requested note is not current_user's note" do
      before do
        login_user @other_user
        patch :update, params: { id: @note.id, note: attributes_for(:note, title: "update_title") }
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
      @note = create(:note, user_id: @user.id)
    end

    context "when the requested note is current_user's note" do
      before do
        login_user @user
      end

      it "destroy the note in the database" do
        expect do
          delete :destroy, params: { id: @note.id, note: @note }
        end.to change(Note, :count).by(-1)
      end

      it "redirects to user_path" do
        delete :destroy, params: { id: @note.id, note: @note }
        expect(response).to redirect_to user_path
      end
    end

    context "when the requested note is not current_user's note" do
      before do
        login_user @other_user
      end

      it "does not destroy the note in the database" do
        expect do
          delete :destroy, params: { id: @note.id, note: @note }
        end.not_to change(Note, :count)
      end

      it "redirects to root_url" do
        delete :destroy, params: { id: @note.id, novel: @note }
        expect(response).to redirect_to root_url
      end
    end
  end
end
