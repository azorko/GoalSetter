class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  attr_reader :password
  
  after_initialize :ensure_session_token

  has_many :goals
  
  has_many :comments, as: :commentable
  
  has_many(
  :authored_comments,
  class_name: "Comment",
  foreign_key: :user_id,
  primary_key: :id
  )
  
  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end
  
  def ensure_session_token
    self.session_token ||= generate_session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    user && user.is_password?(password) ? user : nil
  end
end
