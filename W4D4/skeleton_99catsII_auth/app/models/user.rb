class User < ApplicationRecord
  validates :username, :session_token, presence: true
  validates :password_digest, presence: { message: 'Password can\'t be blank.'}
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_initialize :reset_session_token!

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    return user if user.is_password?(password)
  end

  def reset_session_token!
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  has_many :cats,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :Cat

  has_many :requests,
    class_name: :CatRentalRequest,
    dependent: :destroy
    
end
