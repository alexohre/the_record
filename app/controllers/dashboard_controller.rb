class DashboardController < AuthController
  before_action :authenticate_user!
  

  def index
    @title = current_user.email + " dashboard"
    @user_agent = request.user_agent

    @businesses = Business.joins(:members).where(members: { user_id: current_user.id, roles: 'admin' })
    @business_count = @businesses.count
    
    # @total_users = User.joins(:members).where(members: { business_id: current_user.businesses.ids }).distinct.count

    @total_users = 0
    if current_user.business.any?
      @total_users = User.joins(:members).where(members: { business_id: current_user.business.ids }).distinct.count
    end
  end

  def user_profile
    
  end


end
