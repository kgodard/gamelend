class Lending < ActiveRecord::Base
  belongs_to :game
  belongs_to :borrower, class_name: 'User', foreign_key: :borrower_id
end
