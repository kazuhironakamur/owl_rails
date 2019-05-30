class AddproductdatasToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :maker_code, :string
    add_column :products, :genre_code, :string
    add_column :products, :change_note, :string
    add_column :products, :sch_release_date, :string
    add_column :products, :size, :string
    add_column :products, :package_size, :string
    add_column :products, :package_weight, :decimal
    add_column :products, :size_note, :string
    add_column :products, :battery, :string
    add_column :products, :catchcopy_main, :string
    add_column :products, :catchcopy_long, :string
    add_column :products, :catchcopy_sub1, :string
    add_column :products, :catchcopy_sub2, :string
    add_column :products, :catchcopy_sub3, :string
    add_column :products, :discription, :string
    add_column :products, :usage, :string
    add_column :products, :care, :string
    add_column :products, :detailed_description, :string
    add_column :products, :caution, :string
    add_column :products, :description_path1, :string
    add_column :products, :description_path2, :string
    add_column :products, :target_age, :string
    add_column :products, :accessories, :string
    add_column :products, :manufacture, :string
    add_column :products, :material, :string
    add_column :products, :country_origin, :string
    add_column :products, :inner_carton, :integer
    add_column :products, :outer_carton, :decimal
    add_column :products, :outer_size, :string
    add_column :products, :outer_weight, :decimal
    add_column :products, :cataloged, :boolean
    add_column :products, :catalog_copy, :string
  end
end
