module Naturesoft
  module Galleries
    class GalleriesController < Naturesoft::FrontendController
      before_action :get_gallery, only: [:detail]
      
      def list
        @galleries = Gallery.where(status: "active")
      end
      
      def detail
      end
      
      private
        def get_gallery
          @gallery = Naturesoft::Galleries::Gallery.find(params[:id])
        end
    end
  end
end
