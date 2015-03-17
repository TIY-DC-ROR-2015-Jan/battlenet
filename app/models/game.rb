class Game < ActiveRecord::Base
  serialize :state, JSON

  has_many :game_users
  has_many :players, through: :game_users, source: :user
end
