# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, omniauth_providers: [:twitter]

  has_many :notes, dependent: :destroy
  has_many :novels, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favnovels, through: :favorites, source: :novel

  VALID_NAME_REGEX = /\A[a-zA-Z0-9\-_]+\z/.freeze
  validates :name, presence: true, format: { with: VALID_NAME_REGEX },
                   length: { maximum: 20 }, uniqueness: true

  validates :field, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, format: { with: VALID_EMAIL_REGEX }

  def like(novel)
    favorites.find_or_create_by(novel_id: novel.id)
  end

  def unlike(novel)
    favorite = favorites.find_by(novel_id: novel.id)
    favorite&.destroy
  end

  def favnovel?(novel)
    favnovels.include?(novel)
  end


  protected
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.new(field: auth.info.name,
                      name: auth.info.nickname,
                      email: User.dumy_email(auth),
                      provider: auth.provider,
                      uid: auth.uid,
                      password: Devise.friendly_token[0, 20]
                      )
      user.skip_confirmation!
      user.save!
    end
    user
  end

  private

  def self.dumy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com" 
  end
end
