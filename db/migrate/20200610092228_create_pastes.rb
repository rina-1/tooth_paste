class CreatePastes < ActiveRecord::Migration[5.2]
  def change
    create_table :pastes do |t|
      t.string :tooth_paste_name
      t.string :image_id
      t.integer :price
      t.references :genre, foreign_key: true

      t.timestamps
    end
  end
end
