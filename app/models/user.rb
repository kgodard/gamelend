class User < ActiveRecord::Base
  include Security
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :games
  has_many :lendings, foreign_key: :borrower_id
  has_many :borrowed_games, through: :lendings, source: :game

  def lent_games
    games.select {|g| g.lending.present?}
  end
end
