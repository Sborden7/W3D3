# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  topic      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagTopic < ApplicationRecord
  validates :topic, uniqueness: true, presence: true

  has_many :taggings,
    class_name: "Tagging",
    foreign_key: :tag_id,
    primary_key: :id

  has_many :urls,
    through: :taggings,
    source: :url

  def popular_links
    # Sort urls based on number of Visits
    # Take top 5
    links_with_visits = {}
    urls.each do |url|
      links_with_visits[url.short_url] = url.num_clicks
    end
    links_with_visits.sort_by { |k,v| v }.reverse[0..4]
  end

end
