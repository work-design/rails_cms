module Cms
  class Admin::CarouselsController < Admin::BaseController
    before_action :set_carousel, only: [:show, :edit, :update, :reorder, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params

      @carousels = Carousel.default_where(q_params).order(position: :asc).page(params[:page])
    end

    private
    def set_carousel
      @carousel = Carousel.find params[:id]
    end

  end
end
