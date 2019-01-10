class Cms::Admin::VideosController < Cms::Admin::BaseController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  def index
    @videos = Video.order(id: :desc).page(params[:page])
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      redirect_to admin_videos_url, notice: 'Video was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @video.update(video_params)
      redirect_to admin_videos_url, notice: 'Video was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @video.destroy
    redirect_to admin_videos_url, notice: 'Video was successfully destroyed.'
  end

  private
  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.fetch(:video, {}).permit(
      :title,
      :state,
      :media,
      :cover,
      :author_id,
      :video_taxon_id,
    )
  end

end
