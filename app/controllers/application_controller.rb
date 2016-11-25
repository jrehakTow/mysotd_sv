class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ensure_signup_complete
    return if action_name == 'finish_signup'

    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  def check_items
    items = Item.where(user_id: current_user.id)

    if items.blank?
      redirect_to items_url, alert: 'Please add a shaving item to inventory.'
    end
  end

  def check_twitter
    if $client.nil?
      redirect_to shaving_records_url, alert: 'Not signed in to twitter!'
    end
  end

end
