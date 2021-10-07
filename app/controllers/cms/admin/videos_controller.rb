module Cms
  class Admin::VideosController < Admin::BaseController
    before_action :set_video, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}.with_indifferent_access
      q_params.merge! params.permit(:author_id)
      @videos = Video.default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      q = params.fetch(:video, {}).permit(
        :title,
        :state,
        :media,
        :cover,
        :author_id,
        :video_taxon_id,
      )
      q.merge!(author_id: current_user.id) if q[:author_id].blank?
      q
    end

  end
end
