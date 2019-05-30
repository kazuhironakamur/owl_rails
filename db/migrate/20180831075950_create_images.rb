class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :code
      t.string :filename
      t.string :extension
      t.binary :imagefile

      t.timestamps
    end
  end
end
