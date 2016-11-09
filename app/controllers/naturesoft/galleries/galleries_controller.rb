module Naturesoft
  module Galleries
    class GalleriesController < Naturesoft::FrontendController
      before_action :get_gallery, only: [:detail]
      
      def listing
        @galleries = Gallery.get_active
      end
      
      def detail
      end
      
      private
        def get_gallery
          @gallery = Naturesoft::Galleries::Gallery.find(params[:gallery_id])
        end
    end
  end
end
