class Message < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :chatroom
end
