class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :leagues

  has_many :league_notifications

  has_many :leagues, through: :league_notifications

  has_many :players

  has_many :teams, through: :players

  has_many :messages

end
