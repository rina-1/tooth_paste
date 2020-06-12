class CreateAdminRecommends < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_recommends do |t|
      t.text :comment
      t.references :admin, foreign_key: true
      t.references :paste, foreign_key: true

      t.timestamps
    end
  end
end
