module Naturesoft::Galleries
  class Gallery < ApplicationRecord
    belongs_to :user
    
    def self.filter_image_style
      [
        ["FILL","fill"],
        ["FIT","fit"],
      ]
    end
    def self.sort_by
      [
        ["Name","naturesoft_galleries_galleries.name"],
        ["Height","naturesoft_galleries_galleries.height"],
        ["Width","naturesoft_galleries_galleries.width"],
        ["Created At","naturesoft_galleries_galleries.created_at"]
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
      
      if params[:style].present?
        records = records.where(image_style: params[:style])
      end
      
      #Search keyword filter
      if params[:key].present?
        params[:key].split(" ").each do |k|
          records = records.where("LOWER(CONCAT(naturesoft_galleries_galleries.name,' ',naturesoft_galleries_galleries.height,' ',naturesoft_galleries_galleries.width,' ',naturesoft_galleries_galleries.image_style)) LIKE ?", "%#{k.strip.downcase}%") if k.strip.present?
        end
      end
      
      # for sorting
      sort_by = params[:sort_by].present? ? params[:sort_by] : "naturesoft_galleries_galleries.name"
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
