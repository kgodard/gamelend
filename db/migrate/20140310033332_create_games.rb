class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.string :title
      t.string :developer
      t.string :system

      t.timestamps
    end
  end
end
