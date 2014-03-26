class CreateLendings < ActiveRecord::Migration
  def change
    create_table :lendings do |t|
      t.integer :game_id
      t.integer :borrower_id
      t.date :return_on
      t.date :lent_on

      t.timestamps
    end
  end
end
