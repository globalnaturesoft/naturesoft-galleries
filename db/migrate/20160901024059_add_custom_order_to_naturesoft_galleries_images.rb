class AddCustomOrderToNaturesoftGalleriesImages < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_galleries_images, :custom_order, :integer, default: 0
  end
end
