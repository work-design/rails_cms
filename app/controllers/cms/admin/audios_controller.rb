module Cms
  class Admin::AudiosController < Admin::BaseController
    before_action :set_audio, only: [:show, :edit, :update, :destroy]
    before_action :set_tags, only: [:new, :edit]

    def index
      q_params = {}
      q_params.merge! default_params

      @audios = Audio.includes(audio_tags: :tag, media_attachment: :blob).default_where(q_params).page(params[:page])
    end

    private
    def set_audio
      @audio = Audio.find(params[:id])
    end

    def set_tags
      @tags = Tag.default_where(default_params)
    end

    def audio_params
      p = params.fetch(:audio, {}).permit(
        :title,
        :state,
        :author_id,
        :media,
        :cover,
        tag_ids: []
      )
      p.merge! default_form_params
    end

  end
end
