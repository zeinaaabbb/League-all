class Message < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :chatroom

  validates :content, presence: true
end
