class CreateMemos < ActiveRecord::Migration[6.0]
  def change
    create_table :memos do |t|
      t.integer :user_id
      t.integer :category
      t.text :title
      t.text :text

      t.timestamps
    end
  end
end
