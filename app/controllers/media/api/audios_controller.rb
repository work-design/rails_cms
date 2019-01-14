class Media::Api::AudiosController < Media::Api::BaseController
  before_action :set_audio, only: [:show, :update, :destroy]

  def index
    @audios = Audio.order(id: :desc).page(params[:page])
  end

  def show
    render json: @audio
  end

  def create
    @audio = Audio.new(audio_params)

    if @audio.save
      render json: @audio, status: :created, location: @audio
    else
      render json: @audio.errors, status: :unprocessable_entity
    end
  end

  def update
    if @audio.update(audio_params)
      render json: @audio
    else
      render json: @audio.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @audio.destroy
  end

  private
  def set_audio
    @audio = Audio.find(params[:id])
  end

  def audio_params
    params.fetch(:audio, {})
  end
end
