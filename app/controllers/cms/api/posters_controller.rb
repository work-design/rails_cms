class Cms::Api::PostersController < Cms::Api::BaseController
  before_action :set_poster, only: [:show]

  def index
    @posters = Poster.published.mobile

    render json: { posters: @posters.as_json(methods: [:image_url]) }
  end

  def show
    render json: @poster
  end

  private
  def set_poster
    @poster = Poster.find(params[:id])
  end

end
