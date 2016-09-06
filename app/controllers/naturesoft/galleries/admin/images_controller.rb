module Naturesoft
  module Galleries
    module Admin
      class ImagesController < Naturesoft::Admin::AdminController
        before_action :set_image, only: [:show, :edit, :update, :destroy, :enable, :disable]
        before_action :default_breadcrumb
        
        # add top breadcrumb
        def default_breadcrumb
          add_breadcrumb "Images", naturesoft_galleries.admin_images_path
        end
    
        # GET /images
        def index
          @images = Image.search(params).paginate(:page => params[:page], :per_page => 10)
        end
    
        # GET /images/1
        def show
          add_breadcrumb @image.name, naturesoft_galleries.new_admin_images_path
          add_breadcrumb "Show"
        end
    
        # GET /images/new
        def new
          @image = Image.new
          add_breadcrumb "New Images", naturesoft_galleries.new_admin_image_path
        end
    
        # GET /images/1/edit
        def edit
          add_breadcrumb @image.name, naturesoft_galleries.new_admin_image_path
          add_breadcrumb "Edit"
        end
    
        # POST /images
        def create
          @image = Image.new(image_params)          
          @image.user = current_user
    
          if @image.save
            redirect_to admin_images_path, notice: 'Image was successfully created.'
          else
            render :new
          end
        end
    
        # PATCH/PUT /images/1
        def update
          if @image.update(image_params)
            redirect_to admin_images_path, notice: 'Image was successfully updated.'
          else
            render :edit
          end
        end
    
        # DELETE /images/1
        def destroy
          @image.destroy
          redirect_to admin_images_path, notice: 'Image was successfully destroyed.'
        end

        # ENABLE /images/stutus
        def enable
          @image.enable
          render text: "Status was sucessfully enabled"
        end
        
        # DISABLE /images/stutus
        def disable
          @image.disable
          render text: "Status was sucessfully disabled"
        end
        
        # DELETE /images/delete?ids=1,2,3
        def delete
          @images = Image.where(id: params[:ids].split(","))
          @images.destroy_all
          render text: 'Image(s) was successfully destroyed.'
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_image
            @image = Image.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def image_params
            params.fetch(:image, {}).permit(:name, :description, :image, :gallery_id)
          end
      end
    end
  end
end
