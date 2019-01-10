class Cms::Admin::PostersController < Cms::Admin::BaseController
  before_action :set_poster, only: [:show, :edit, :update, :destroy]

  def index
    @posters = Poster.order(id: :desc).page(params[:page])
  end

  def new
    @poster = Poster.new
  end

  def create
    @poster = Poster.new(poster_params)

    if @poster.save
      redirect_to admin_posters_url, notice: 'Poster was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @poster.update(poster_params)
      redirect_to admin_posters_url, notice: 'Poster was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @poster.destroy
    redirect_to admin_posters_url, notice: 'Poster was successfully destroyed.'
  end

  private
  def set_poster
    @poster = Poster.find(params[:id])
  end

  def poster_params
    params.fetch(:poster, {}).permit(
      :title,
      :link,
      :linking_type,
      :linking_id,
      :published,
      :image,
      :platform
    )
  end

end
