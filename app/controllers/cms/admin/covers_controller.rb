module Cms
  class Admin::CoversController < Admin::BaseController
    before_action :set_cover, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params

      @covers = Cover.includes(media_attachment: :blob).default_where(q_params).page(params[:page])
    end

    private
    def set_cover
      @cover = Cover.find(params[:id])
    end

    def cover_params
      p = params.fetch(:cover, {}).permit(
        :title,
        :state,
        :author_id,
        :media
      )
      p.merge! default_form_params
    end

  end
end
