class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.order(id: :desc).page(params[:page])
  end
end
