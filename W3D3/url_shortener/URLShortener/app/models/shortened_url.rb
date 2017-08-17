class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, :user_id, presence: true

  def self.random_code
    random_url = SecureRandom.urlsafe_base64
    while self.exists?(short_url: random_url)
      random_url = SecureRandom.urlsafe_base64
    end
    random_url
  end

  def self.make_shortend_url(user, long_url)
    user_id = user.id
    short_url = self.random_code
    ShortenedUrl.create!(user_id: user_id, long_url: long_url, short_url: short_url)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    users = visitors
    ten_minutes_ago = 10.minutes.ago
    Visit.where(["created_at > ? AND shortened_url_id = ?", "#{ten_minutes_ago}", self.id]).uniq.count
  end

  belongs_to :submitter,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id


  has_many :visits,
    class_name: :Visit,
    foreign_key: :shortened_url_id,
    primary_key: :id

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user
end
