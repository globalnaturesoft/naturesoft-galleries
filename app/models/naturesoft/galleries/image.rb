module Naturesoft::Galleries
  class Image < ApplicationRecord
		include Naturesoft::CustomOrder
		
    belongs_to :user
    belongs_to :gallery
    validates :image, presence: true
		validates :image, allow_blank: true, format: {
			with: %r{\.(gif|jpg|png)\Z}i,
			message: 'must be a URL for GIF, JPG or PNG image.'
		}
    mount_uploader :image, Naturesoft::Galleries::ImageUploader
    
    def self.sort_by
      [
        ["Custom order","naturesoft_galleries_images.custom_order"],
        ["Name","naturesoft_galleries_images.name"],
        ["Created At","naturesoft_galleries_images.created_at"]
      ]
    end
    def self.sort_orders
      [
        ["ASC","asc"],
        ["DESC","desc"]
      ]
    end
    
    #Filter, Sort
    def self.search(params)
      records = self.all
      
      if params[:gallery_id].present?
        records = records.where(gallery_id: params[:gallery_id])
      end
      
      #Search keyword filter
      if params[:key].present?
        params[:key].split(" ").each do |k|
          records = records.where("LOWER(CONCAT(naturesoft_galleries_images.name,' ',naturesoft_galleries_images.description)) LIKE ?", "%#{k.strip.downcase}%") if k.strip.present?
        end
      end
      
      # for sorting
      sort_by = params[:sort_by].present? ? params[:sort_by] : "naturesoft_galleries_images.name"
      sort_orders = params[:sort_orders].present? ? params[:sort_orders] : "asc"
      records = records.order("#{sort_by} #{sort_orders}")
      
      return records
    end
    
    # enable/disable status
    def enable
			update_columns(status: "active")
		end
    
    def disable
			update_columns(status: "inactive")
		end
  end
end
