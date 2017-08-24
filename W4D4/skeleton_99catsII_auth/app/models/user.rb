class User < ApplicationRecord
  validates :username, :session_token, presence: true
  validates :password_digest, presence: { message: 'Password can\'t be blank.'}
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_initialize :ensure_session_token

  attr_reader :password

  has_many :cats,
  foreign_key: :user_id,
  primary_key: :id,
  class_name: :Cat

  has_many :requests,
  class_name: :CatRentalRequest,
  dependent: :destroy

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
    self.session_token = new_session_token
    self.save!
    # self.session_token ||= new_session_token
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def new_session_token
    SecureRandom.urlsafe_base64
  end

  def generate_unique_session_token
    self.session_token = new_session_token
    while User.exists?(session_token: self.session_token)
      self.session_token = new_session_token
    end

    self.session_token
  end

end

# Aarons unique session token auth pattern
# class User < ApplicationRecord
#   attr_reader :password
#
#   validates :email, :password_digest, :session_token, presence: true
#   validates :email, uniqueness: true
#   validates :password, length: { minimum: 6 }, allow_nil: :true
#
#   after_initialize :ensure_session_token
#
#
#   def password=(password)
#     self.password_digest = BCrypt::Password.create(password)
#     @password = password
#   end
#
#   def self.find_by_credentials(email, password)
#     user = User.find_by(email: email)
#     return nil unless user
#     user.password_is?(password) ? user : nil
#   end
#
#   def password_is?(password)
#     BCrypt::Password.new(self.password_digest).is_password?(password)
#   end
#
#   def reset_session_token!
#     generate_unique_session_token
#     save!
#     self.session_token
#   end
#
#   private
#
#   def ensure_session_token
#     generate_unique_session_token unless self.session_token
#   end
#
#   def new_session_token
#     SecureRandom.urlsafe_base64
#   end
#
#   def generate_unique_session_token
#     self.session_token = new_session_token
#     while User.exists?(session_token: self.session_token)
#       self.session_token = new_session_token
#     end
#
#     self.session_token
#   end
# end
