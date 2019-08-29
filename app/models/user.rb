class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, omniauth_providers: [:twitter]
  
  has_many :notes
  has_many :novels
  has_many :reviews
  has_many :favorites, dependent: :destroy
  has_many :favnovels, through: :favorites, source: :novel
  
  
  VALID_NAME_REGEX = /\A[a-zA-Z0-9\-_]+\z/
  validates :name, presence: true, format: { with: VALID_NAME_REGEX }, 
                   length: { maximum: 50 }, uniqueness: true
  
  validates :field, presence: true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  
  def like(novel)
    favorites.find_or_create_by(novel_id: novel.id)
  end
  
  def unlike(novel)
    favorite = favorites.find_by(novel_id: novel.id)
    favorite.destroy if favorite
  end
  
  def favnovel?(novel)
    self.favnovels.include?(novel)
  end
  
  def self.from_omniauth(auth)
    find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
      end
    else
      super
    end
  end
end
