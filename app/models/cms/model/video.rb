# frozen_string_literal: true
module Cms
  module Model::Video
    WM_PREFIX = '0wm'
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :share_count, :integer, default: 0
      attribute :view_count, :integer, default: 0
      attribute :liked_count, :integer, default: 0
      attribute :comments_count, :integer, default: 0
      attribute :water_mark_job, :string

      enum state: {
        draft: 'draft',
        verified: 'verified',
        rejected: 'rejected'
      }, _default: 'draft'

      belongs_to :author, class_name: 'Auth::User', optional: true
      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :video_taxon, optional: true

      has_many :taggeds, as: :tagging, dependent: :delete_all
      has_many :tags, through: :taggeds
      has_many :attitudes, as: :attitudinal, dependent: :delete_all
      has_many :progressions, as: :progressive, dependent: :delete_all

      has_one_attached :media
      has_one_attached :cover

      after_create_commit :doing_water_mark
      after_create_commit :doing_video_tag
    end

    def do_trigger(params = {})
      self.trigger_to state: params[:state]

      self.class.transaction do
        self.save!
        to_notification(
          receiver: self.author,
          linked: self,
          verbose: true
        ) if self.author
      end
    end

    def viewed?(user_id)
      progressions.done.exists?(user_id: user_id)
    end

    def media_url
      media.blob.service_url if media.attachment.present?
    end

    def media_wm_url
      if water_mark_job
        QiniuHelper.download_url([WM_PREFIX, self.media_blob&.key].join('_'))
      else
        media_url
      end
    end

    def cover_url
      cover.blob.service_url if cover.attachment.present?
    end

    def pre_videos(params = {})
      per = params.delete(:per) || 10
      q = { 'id-gt': self.id }.merge params

      self.class.default_where(q).order(id: :asc).limit(per)
    end

    def next_videos(params = {})
      per = params.delete(:per) || 10
      q = { 'id-lt': self.id }.merge params

      self.class.default_where(q).order(id: :desc).limit(per)
    end

    def share_url(current_user)
      url_helpers = Rails.application.routes.url_helpers

      if current_user
        url_helpers.video_url(self.id, user_id: current_user.id)
      else
        url_helpers.video_url(self.id)
      end
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
      if RailsMedia.config.water_mark
        VideoWmJob.perform_later(self)
      end
    end

    def cache_entity_logs
      self.update share_count: logs_count('share_video')
    end

    def doing_video_tag
      reg = /#[^#]+[#|\s]/
      r = self.title.scan(reg)
      tag_str = r.map do |tag|
        tag.gsub(/(^#|#$)/, '')
      end
      tag_ids = tag_str.map do |tag|
        VideoTag.find_or_create_by(name: tag).id
      end
      self.tag_ids = tag_ids
    end

  end
end
