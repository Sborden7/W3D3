class AddIndexToShortenedUrl < ActiveRecord::Migration[5.1]
  def change
    add_index :shortened_urls, :submitter_id
  end
end
