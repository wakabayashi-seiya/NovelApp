# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :logged_in_user, only: %i[new create edit update]
  before_action :find_note, only: %i[edit update destroy]

  def new
    @note = current_user.notes.build if user_signed_in?
  end

  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      flash[:success] = '近況ノートを投稿しました'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @note.update(note_params)
      flash[:success] = '近況ノートを編集しました'
      redirect_to @note
    else
      render 'edit'
    end
  end

  def destroy
    @note.destroy
    flash[:success] = 'ノートを1件削除しました'
    redirect_to user_path
  end

  def show
    @note = Note.find(params[:id])
  end

  private

  def note_params
    params.require(:note).permit(:title, :text)
  end

  def find_note
    @note = current_user.notes.find_by(id: params[:id])
    redirect_to root_url if @note.nil?
  end
end
