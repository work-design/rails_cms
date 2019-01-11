class Topic < ApplicationRecord
  attribute :state, :string, default: 'init'

  belongs_to :author, class_name: 'User', optional: true
  has_many :comments, as: :commentable
  has_many :stars, as: :starred
  has_many :attitudes, as: :attitudinal, dependent: :delete_all

  has_many_attached :images

  def image_urls
    images.map(&:service_url)
  end

end
