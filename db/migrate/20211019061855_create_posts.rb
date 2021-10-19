class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :area_id,null: false
      t.integer :genre_id,null: false
      t.integer :scene_id,null: false
      t.timestamps
    end
  end
end
