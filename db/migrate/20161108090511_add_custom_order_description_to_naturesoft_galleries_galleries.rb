class AddCustomOrderDescriptionToNaturesoftGalleriesGalleries < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_galleries_galleries, :custom_order, :integer, default: 0
    add_column :naturesoft_galleries_galleries, :description, :text
  end
end
