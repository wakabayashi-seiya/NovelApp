require "rails_helper"

RSpec.describe "Favorites", type: :request do
  before do
    @user = create(:user)
    @other_user = create(:other_user)
    @genre = create(:genre)
    @novel = create(:novel, user_id: @user.id, genre_id: @genre.id)
  end
  
  example "current_user is the novel auther" do
    sign_in @user
    get novel_path(@novel)
    expect(response).to render_template(:show)
    expect(response.body).not_to include('本棚に追加')
  end
  
  example "current_user is not the novel auther" do
    sign_in @other_user
    get novel_path(@novel)
    expect(response).to render_template(:show)
    expect(response.body).to include('本棚に追加')
    expect do
      post favorites_path, params: { novel_id: @novel.id }
    end.to change(@other_user.favorites, :count).by(1)
    get novel_path(@novel)
    expect(response.body).to include('本棚から外す')
    expect do
      delete favorite_path, params: { novel_id: @novel.id }
    end.to change(@other_user.favorites, :count).by(-1)
    get novel_path(@novel)
    expect(response.body).to include('本棚に追加')
  end
  
end