class CreateContentFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :content_favorites do |t|
      t.integer :user_id
      t.integer :content_id

      t.timestamps
    end
  end
end
