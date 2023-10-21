module Cms
  module Model::Cover
    extend ActiveSupport::Concern

    included do
      attribute :title, :string

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_one_attached :media
    end

    def media_url
      media.url if media.attachment.present?
    end

    def cover_url
      cover.service_url if cover.attachment.present?
    end

  end
end
