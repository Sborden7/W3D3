# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  false        :integer
#  short_url    :string
#  submitter_id :integer
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  belongs_to :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id

  has_many :visits,
    class_name: "Visit",
    foreign_key: :url_id,
    primary_key: :id

  has_many :visitors,
    -> {distinct},
    through: :visits,
    source: :visitor

  has_many :taggings,
    class_name: "Tagging",
    foreign_key: :url_id,
    primary_key: :id

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic

  def self.random_code
    url_code = SecureRandom.urlsafe_base64[0...16]
    while self.exists?(short_url: url_code)
      url_code = SecureRandom.urlsafe_base64[0...16]
    end
    url_code
  end

  def self.create_short_url(submitter, old_url)
    url_code = ShortenedUrl.random_code
    ShortenedUrl.create!(long_url: old_url, submitter_id: submitter.id, short_url: url_code)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
    # User.select(:user_id).where(url_id: self.id).
  end

  def num_recent_uniques
    ten_mins_ago = Time.now - 10*60
    visits.where("visits.created_at > ?", ten_mins_ago).count
  end
end
