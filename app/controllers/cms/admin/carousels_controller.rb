module Cms
  class Admin::CarouselsController < Admin::BaseController
    before_action :set_carousel, only: [:show, :edit, :update, :reorder, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params

      @carousels = Carousel.default_where(q_params).order(position: :asc).page(params[:page])
    end

    def reorder
      sort_array = params[:sort_array].select { |i| i.integer? }

      if params[:new_index] > params[:old_index]
        prev_one = @carousel.class.find(sort_array[params[:new_index].to_i - 1])
        @carousel.insert_at prev_one.position
      else
        next_ones = @carousel.class.find(sort_array[(params[:new_index].to_i + 1)..params[:old_index].to_i])
        next_ones.each do |next_one|
          next_one.insert_at @carousel.position
        end
      end
    end

    private
    def set_carousel
      @carousel = Carousel.find params[:id]
    end

  end
end
