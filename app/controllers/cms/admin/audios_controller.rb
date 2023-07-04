module Cms
  class Admin::AudiosController < Admin::BaseController
    before_action :set_audio, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params

      @audios = Audio.includes(media_attachment: :blob).default_where(q_params).page(params[:page])
    end

    private
    def set_audio
      @audio = Audio.find(params[:id])
    end

    def audio_params
      p = params.fetch(:audio, {}).permit(
        :title,
        :state,
        :author_id,
        :media
      )
      p.merge! default_form_params
    end

  end
end
