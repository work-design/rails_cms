module Cms
  module Ext::User
    extend ActiveSupport::Concern

    included do
      has_many :videos, class_name: 'Cms::Video', foreign_key: :author_id
    end

    def videos_count
      if defined?(super) && super
        super
      else
        videos.count
      end
    end

    def video_liked_count
      videos.sum(:liked_count)
    end

    def video_comments_count
      videos.sum(:comments_count)
    end

  end
end
