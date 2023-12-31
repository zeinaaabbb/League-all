# To deliver this notification:
#
LeagueNotification.with(post: @post).deliver_later(current_user)
LeagueNotification.with(post: @post).deliver(current_user)
# LeagueNotification.deliver_later(User.all) <- MAKE THIS USERS IN A LEAGUE?

class LeagueNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :post

  # Define helper methods to make rendering easier.
  #
  def message
    t(".message")
  end
  #
  def url
    post_path(params[:post])
  end
end
