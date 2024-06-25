class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  layout "admin"

  private

  def authorize_admin!
    redirect_to root_path, alert: "You must be an admin to view this page." unless current_user.admin?
  end
end
