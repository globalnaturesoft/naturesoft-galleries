module Naturesoft
  module Galleries
    module Admin
      class GalleriesController < Naturesoft::Admin::AdminController
        before_action :set_gallery, only: [:show, :edit, :update, :destroy, :enable, :disable]
        before_action :default_breadcrumb
        
        # add top breadcrumb
        def default_breadcrumb
          add_breadcrumb "Galleries", naturesoft_galleries.admin_galleries_path
        end
    
        # GET /galleries
        def index
          @galleries = Gallery.search(params).paginate(:page => params[:page], :per_page => 10)
        end
    
        # GET /galleries/1
        def show
          add_breadcrumb @galleries.name, naturesoft_galleries.new_admin_galleries_path
          add_breadcrumb "Show"
        end
    
        # GET /galleries/new
        def new
          @gallery = Gallery.new
          add_breadcrumb "New Gallery", naturesoft_galleries.new_admin_gallery_path
        end
    
        # GET /galleries/1/edit
        def edit
          add_breadcrumb @gallery.name, naturesoft_galleries.new_admin_gallery_path
          add_breadcrumb "Edit"
        end
    
        # POST /galleries
        def create
          @gallery = Gallery.new(gallery_params)
          @gallery.user = current_user
    
          if @gallery.save
            redirect_to admin_galleries_path, notice: 'Gallery was successfully created.'
          else
            render :new
          end
        end
    
        # PATCH/PUT /galleries/1
        def update
          if @gallery.update(gallery_params)
            redirect_to admin_galleries_path, notice: 'Gallery was successfully updated.'
          else
            render :edit
          end
        end
    
        # DELETE /galleries/1
        def destroy
          @gallery.destroy
          redirect_to admin_galleries_path, notice: 'Gallery was successfully destroyed.'
        end
        
        # ENABLE /galleries/stutus
        def enable
          @gallery.enable
          render text: "Status was sucessfully enabled"
        end
        
        # DISABLE /galleries/stutus
        def disable
          @gallery.disable
          render text: "Status was sucessfully disabled"
        end
        
        # DELETE /galleries/delete?ids=1,2,3
        def delete
          @galleries = Gallery.where(id: params[:ids].split(","))
          @galleries.destroy_all
          render text: 'Galler(y/ies) was successfully destroyed.'
        end
        
        # GET /galleries/select2
        def select2
          render json: Gallery.select2(params)
        end
        
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_gallery
            @gallery = Gallery.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def gallery_params
            params.fetch(:gallery, {}).permit(:name,
              :height,
              :width,
              :image_style,
              images_attributes: [:id, :is_main, :user_id, :image, :name, :_destroy]
            )
          end
      end
    end
  end
end
