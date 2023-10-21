module Cms
  class AudiosController < BaseController
    before_action :set_audio, only: [:show, :update, :destroy]

    def index
      @audios = Audio.order(id: :desc).page(params[:page])
    end

    private
    def set_audio
      @audio = Audio.find(params[:id])
    end
  end
end
