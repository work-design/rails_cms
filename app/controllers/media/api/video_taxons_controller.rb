class Cms::Api::VideoTaxonsController < Cms::Api::BaseController
  before_action :set_video_taxon, only: [:show, :update, :destroy]

  def index
    @video_taxons = VideoTaxon.all

    render json: { video_taxons: @video_taxons.as_json(only: [:id, :name, :position]) }
  end

  def show
    render json: @video_taxon
  end

  def create
    @video_taxon = VideoTaxon.new(video_taxon_params)

    if @video_taxon.save
      render json: @video_taxon, status: :created, location: @video_taxon
    else
      render json: @video_taxon.errors, status: :unprocessable_entity
    end
  end

  def update
    if @video_taxon.update(video_taxon_params)
      render json: @video_taxon
    else
      render json: @video_taxon.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @video_taxon.destroy
  end

  private
  def set_video_taxon
    @video_taxon = VideoTaxon.find(params[:id])
  end

  def video_taxon_params
    params.fetch(:video_taxon, {})
  end
end
