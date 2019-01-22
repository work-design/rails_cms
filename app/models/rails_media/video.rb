class Video < ApplicationRecord
  include RailsGrowthEntity
  include RailsInteractLike
  attribute :share_count, :integer, default: 0
  attribute :liked_count, :integer, default: 0

  belongs_to :author, class_name: 'User', optional: true
  belongs_to :video_taxon, optional: true
  has_many :comments, as: :commentable
  has_many :taggeds, as: :tagging, dependent: :delete_all
  has_many :tags, through: :taggeds
  has_many :attitudes, as: :attitudinal, dependent: :delete_all
  has_many :progressions, as: :progressive, dependent: :delete_all

  has_one_attached :media
  has_one_attached :cover

  def viewed?(user_id)
    progressions.done.exists?(user_id: user_id)
  end

  def media_url
    media.service_url if media.attachment.present?
  end

  def cover_url
    cover.service_url if cover.attachment.present?
  end

  def pre_videos(per = 10)
    self.class.default_where('id-lt': self.id).order(id: :desc).limit(per)
  end

  def next_videos(per = 10)
    self.class.default_where('id-gt': self.id).order(id: :asc).limit(per)
  end

  def share_url
    'http://dappore.store'
  end

end
