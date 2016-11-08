module Naturesoft::Galleries
  class Gallery < ApplicationRecord
		include Naturesoft::CustomOrder
    belongs_to :user
    validates :name, :width, :height, presence: true
    has_many :images, dependent: :destroy, :inverse_of => :gallery
    accepts_nested_attributes_for :images,
			:reject_if => lambda { |a| a[:image].blank? && a[:id].blank? },
			:allow_destroy => true
		
		after_save :recreate_thumbs
    
    def recreate_thumbs
			images.each do |i|
				i.recreate_thumbs
			end
		end
    
    def self.filter_image_style
      [
        ["FILL","fill"],
        ["FIT","fit"],
      ]
    end
    def self.sort_by
      [
        ["Custom order","naturesoft_galleries_galleries.custom_order"],
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
    
    # get newest default image
    def main_image
			return Image.new if images.empty?
			
			img = images.where(is_main: true).last
			return img.nil? ? images.last : img
		end
    
    # data for select2 ajax
    def self.select2(params)
			items = self.search(params)
			if params[:excluded].present?
				items = items.where.not(id: params[:excluded].split(","))
			end
			options = [{"id" => "", "text" => "none"}]
			options += items.map { |c| {"id" => c.id, "text" => c.name} }
			result = {"items" => options}
		end
  end
end
