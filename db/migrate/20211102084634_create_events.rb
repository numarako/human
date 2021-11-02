class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :status
      t.text :reason
      t.text :small_success

      t.timestamps
    end
  end
end
