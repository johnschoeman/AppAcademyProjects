class SessionToken < ApplicationRecord
  validates :user_id, :session_token, presence: true

  belongs_to :user,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User
    
end
