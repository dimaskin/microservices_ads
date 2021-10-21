class CreateAds < ActiveRecord::Migration[6.1]
  def change
    create_table :ads do |t|

      t.string :title, null: false
      t.string :description, text: true, null: false
      t.string :city, null: false
      t.bigint :user_id, null: false
      t.float :lat
      t.float :lon
      t.timestamps

      t.index :user_id
    end
  end
end
