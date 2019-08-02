class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable
  has_many :notes
  has_many :novels
  has_many :reviews
  has_many :favorites, dependent: :destroy
  has_many :favnovels, through: :favorites, source: :novel
  before_save :downcase_email
  before_create :create_activation_digest
  attr_accessor :remember_token, :activation_token, :reset_token
  VALID_NAME_REGEX = /\A[a-zA-Z0-9\-_]+\z/
  validates :name, presence: true, format: { with: VALID_NAME_REGEX }, 
                   length: { maximum: 50 }, uniqueness: true
  validates :field, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    length: { maximum: 255}, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  

  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def User.digest(string) 
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
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
  
    
  private
  
    def downcase_email
      self.email = email.downcase
    end
    
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
  
end
