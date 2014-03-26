class Game < ActiveRecord::Base
  belongs_to :user
  has_one :lending
  has_one :borrower, through: :lending
end
