class Media::Admin::AudiosController < Media::Admin::BaseController
  before_action :set_audio, only: [:show, :edit, :update, :destroy]

  def index
    @audios = Audio.page(params[:page])
  end

  def new
    @audio = Audio.new
  end

  def create
    @audio = Audio.new(audio_params)

    if @audio.save
      redirect_to admin_audios_url, notice: 'Audio was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @audio.update(audio_params)
      redirect_to admin_audios_url, notice: 'Audio was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @audio.destroy
    redirect_to admin_audios_url, notice: 'Audio was successfully destroyed.'
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
