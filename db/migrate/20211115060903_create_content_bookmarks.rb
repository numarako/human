class CreateContentBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :content_bookmarks do |t|
      t.references :user, foreign_key: true, null: false
      t.references :content, foreign_key: true, null: false

      t.timestamps
    end
  end
end
