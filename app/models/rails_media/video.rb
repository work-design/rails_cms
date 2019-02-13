class Video < ApplicationRecord
  WM_PREFIX = '0wm'
  acts_as_notify :default, methods: [:state_i18n]

  include CheckMachine
  include RailsGrowthEntity
  include RailsInteractLike
  include RailsInteractComment
  attribute :share_count, :integer, default: 0
  attribute :view_count, :integer, default: 0
  attribute :liked_count, :integer, default: 0
  attribute :comments_count, :integer, default: 0
  attribute :state, :string, default: 'draft'

  belongs_to :author, class_name: 'User', optional: true
  belongs_to :video_taxon, optional: true
  has_many :taggeds, as: :tagging, dependent: :delete_all
  has_many :tags, through: :taggeds
  has_many :attitudes, as: :attitudinal, dependent: :delete_all
  has_many :progressions, as: :progressive, dependent: :delete_all

  has_one_attached :media
  has_one_attached :cover

  after_create_commit :doing_water_mark
  after_create_commit :doing_video_tag

  enum state: {
    draft: 'draft',
    verified: 'verified',
    rejected: 'rejected'
  }

  def do_trigger(params = {})
    self.trigger_to state: params[:state]

    self.class.transaction do
      self.save!
      to_notification(
        receiver: self.author,
        link: url_helpers.admin_videos_url(id: self.id),
        verbose: true
      ) if self.author
    end
  end

  def viewed?(user_id)
    progressions.done.exists?(user_id: user_id)
  end

  def media_url
    media.service_url if media.attachment.present?
  end

  def media_wm_url
    if water_mark_job
      QiniuHelper.download_url([WM_PREFIX, self.media_blob&.key].join('_'))
    else
      media_url
    end
  end

  def cover_url
    cover.service_url if cover.attachment.present?
  end

  def pre_videos(per = 10)
    self.class.default_where('id-gt': self.id).order(id: :asc).limit(per)
  end

  def next_videos(per = 10)
    self.class.default_where('id-lt': self.id).order(id: :desc).limit(per)
  end

  def share_url
    'http://dappore.store'
  end

  def water_mark
    if water_mark_job.blank?
      r = QiniuHelper.av_watermark(self.media.key, RailsMedia.config.water_mark_url, gravity: 'North', prefix: WM_PREFIX)
      self.update(water_mark_job: r['persistentId'])
      r
    else
      r = QiniuHelper.prefop(water_mark_job)
      self.update(water_mark_job: r['desc'])
      r
    end
  end

  def doing_water_mark
    VideoWmJob.perform_later(self)
  end

  def doing_video_tag
    reg = /#[^#]+[#|\s]/
    r = self.title.scan(reg)
    tag_strs = r.map do |tag|
      tag.gsub(/(^#|#$)/, '')
    end
    tag_ids = tag_strs.map do |tag|
      VideoTag.find_or_create_by(name: tag).id
    end
    self.tag_ids = tag_ids
  end

end
