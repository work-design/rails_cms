module Cms
  class AudiosController < BaseController
    before_action :set_audio, only: [:show, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! 'audio_tags.tag_id': params[:tag_id] if params[:tag_id].present?
      q_params.merge! default_params

      @audios = Audio.default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def set_audio
      @audio = Audio.find(params[:id])
    end
  end
end
