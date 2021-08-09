# frozen_string_literal: true

# 近況ノートに関するクラス
class NotesController < ApplicationController
  before_action :logged_in_user, only: %i[new create edit update]
  before_action :find_note, only: %i[edit update destroy]

  # 近況ノートの投稿ページ
  def new
    # 投稿ページ用の空のオブジェクトを作成
    @note = current_user.notes.build if user_signed_in?
  end

  # 投稿ボタンを押して、近況ノートを投稿する
  def create
    # ストロングパラメータを元に、オブジェクトを生成
    @note = current_user.notes.build(note_params)
    if @note.save
      flash[:success] = '近況ノートを投稿しました'
      redirect_to root_url
    else
      render 'new'
    end
  end

  # 近況ノートの編集ページ
  # アクションの前に、find_noteが実行される
  def edit; end

  # 更新ボタンを押して、近況ノートを更新
  # アクションの前に、find_noteが実行される
  def update
    if @note.update(note_params)
      flash[:success] = '近況ノートを編集しました'
      redirect_to @note
    else
      render 'edit'
    end
  end

  # 近況ノートの削除
  def destroy
    @note.destroy
    flash[:success] = 'ノートを1件削除しました'
    redirect_to user_path
  end

  # 特定の近況ノートの閲覧ページ
  def show
    @note = Note.find(params[:id])
  end

  private

  # ストロングパラメータの登録
  def note_params
    params.require(:note).permit(:title, :text)
  end

  # 近況ノートを特定する
  def find_note
    @note = current_user.notes.find_by(id: params[:id])
    redirect_to root_url if @note.nil?
  end
end
