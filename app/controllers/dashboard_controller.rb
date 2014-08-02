class DashboardController < FrontController

  def index
    @accounts = current_user.accounts
  end

end