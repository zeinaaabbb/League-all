class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :user_notifications

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role, :date_of_birth, :photo])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :role, :date_of_birth, :photo])
  end

  def user_notifications
    if current_user
      @notifications = Notification.where(recipient_type: "User", recipient_id: current_user.id, read_at: nil)
    else
      @notifications = []
    end
  end
end
