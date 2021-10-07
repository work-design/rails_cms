module Cms
  class VideoTaxonsController < BaseController
    before_action :set_video_taxon, only: [:show]

    def index
      @video_taxons = VideoTaxon.page(params[:page])

      render json: { video_taxons: @video_taxons.as_json(only: [:id, :name, :position]) }
    end

    private
    def set_video_taxon
      @video_taxon = VideoTaxon.find(params[:id])
    end
  end
end
