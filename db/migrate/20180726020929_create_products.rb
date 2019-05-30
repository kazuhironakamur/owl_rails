class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :code
      t.text :catchcopy
      t.integer :weight_g

      t.timestamps
    end
  end
end
