module Cms
  class Admin::AudiosController < Admin::BaseController
    before_action :set_audio, only: [:show, :edit, :update, :destroy]

    def index
      @audios = Audio.page(params[:page])
    end

    private
    def set_audio
      @audio = Audio.find(params[:id])
    end

    def audio_params
      params.fetch(:audio, {}).permit(
        :title,
        :state,
        :author_id,
        :media
      )
    end

  end
end
