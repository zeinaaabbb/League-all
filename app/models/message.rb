class Message < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :chatroom

  validates :content, presence: true

  def sender?(a_user)
    user.id == a_user.id
  end

end
