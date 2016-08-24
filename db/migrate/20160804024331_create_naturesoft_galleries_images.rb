class CreateNaturesoftGalleriesImages < ActiveRecord::Migration[5.0]
  def change
    create_table :naturesoft_galleries_images do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :status, :default => "active"
      t.references :user, references: :naturesoft_users, index: true
      t.references :gallery, references: :naturesoft_galleries_galleries, index: true

      t.timestamps
    end
  end
end
