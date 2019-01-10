class Audio < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true
  has_one_attached :media
  has_one_attached :cover

  def media_url
    media.service_url if media.attachment.present?
  end

  def cover_url
    cover.service_url if cover.attachment.present?
  end

  def duration
    media_blob.duration
  end

end
