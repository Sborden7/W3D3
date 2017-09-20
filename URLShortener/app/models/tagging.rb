# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  url_id     :integer          not null
#  tag_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tagging < ApplicationRecord
  validates :url_id, :tag_id, presence: true

  belongs_to :url,
    class_name: "ShortenedUrl",
    foreign_key: :url_id,
    primary_key: :id

  belongs_to :tag_topic,
    class_name: "TagTopic",
    foreign_key: :tag_id,
    primary_key: :id
end
