module Cms
  class VideoTagsController < BaseController
    before_action :set_video_tag, only: [:show, :update]

    def index
      @video_tags = VideoTag.page(params[:page]).per(params[:per])

      render json: { video_tags: @video_tags.as_json(only: [:id, :name]) }
    end

    private
    def set_video_tag
      @video_tag = VideoTag.find(params[:id])
    end

    def video_tag_params
      params.fetch(:video_tag, {}).permit(:name)
    end
  end
end
