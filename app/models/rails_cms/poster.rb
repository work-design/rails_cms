class Poster < ApplicationRecord
  has_one_attached :image
  scope :published, -> { where(published: true) }

  enum platform: {
    pc: 'pc',
    mobile: 'mobile'
  }

  def image_url
    image.service_url if image.attachment.present?
  end
end
