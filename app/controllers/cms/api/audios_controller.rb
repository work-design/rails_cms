class Media::Api::AudiosController < Media::Api::BaseController
  before_action :set_audio, only: [:show, :update, :destroy]

  def index
    @audios = Audio.order(id: :desc).page(params[:page])
  end

  private
  def set_audio
    @audio = Audio.find(params[:id])
  end

  def audio_params
    params.fetch(:audio, {})
  end
end
