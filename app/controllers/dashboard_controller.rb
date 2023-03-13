class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @title = current_user.email + " dashboard"
  end
end
