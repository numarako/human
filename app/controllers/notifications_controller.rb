class NotificationsController < ApplicationController
  before_action :logged_in_user
  
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).includes([:content])
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
