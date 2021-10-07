module Cms
  module Model::Audio
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :state, :string

      belongs_to :author, class_name: 'Auth::User', optional: true

      has_one_attached :media
      has_one_attached :cover
    end

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
end
