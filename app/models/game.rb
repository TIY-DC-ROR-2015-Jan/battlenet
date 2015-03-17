class Game < ActiveRecord::Base
  serialize :state, JSON

  validates_presence_of :current_player_id, :state

  has_many :game_users
  has_many :players, through: :game_users, source: :user

  scope :battleship, -> { where(type: "Battleship") }

  class IllegalMove < StandardError; end
end
