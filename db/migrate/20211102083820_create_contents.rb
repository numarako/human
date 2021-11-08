class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.integer :user_id
      t.text :title
      t.integer :emotions
      t.integer :score
      t.text :journaling
      t.text :situation
      t.text :compassion
      t.boolean :release

      t.timestamps
    end
  end
end
