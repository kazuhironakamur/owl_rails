class AddIndexImagesFilename < ActiveRecord::Migration[5.1]
  def change
    add_index :images, :filename, unique: true
  end
end
