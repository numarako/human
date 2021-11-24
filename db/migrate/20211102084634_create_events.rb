class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :mind
      t.text :reason
      t.text :small_success
      t.text :small_thanks
      t.date :date

      t.timestamps
    end
  end
end
