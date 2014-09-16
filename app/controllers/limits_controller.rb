class LimitsController < FrontController

  def index
    @limits = current_user.limits
  end

  def new
    @limit = Limit.new
    @accounts = current_user.accounts
  end

  def create
    @limit = Limit.new(params.require(:limit).permit(:name, :value, :value_currency, :period))
    @accounts = current_user.accounts
    @limit.account = @accounts.find(params[:limit][:account_id])
    if @limit.save
      redirect_to limits_path
    else
      render :new
    end
  end

  def show
    @limit = current_user.limits.find(params[:id])
  end

end