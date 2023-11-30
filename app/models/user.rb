class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo

  has_many :leagues, dependent: :destroy

  has_many :league_notifications

  has_many :joined_leagues, through: :league_notifications, :source => 'league'

  has_many :players

  has_many :teams, through: :players

  has_many :teams, dependent: :destroy

  has_many :messages

end
