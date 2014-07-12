class AccountsController < FrontController

  def index
    @accounts = current_user.accounts
  end

  def new
    @account = Account.new
  end

  def show
    @account = current_user.accounts.find(params[:id])
  end

  def create
    @account = current_user.accounts.new(params.require(:account).permit(:name))
    if @account.save
      redirect_to action: 'show', :id => @account.id
    else
      render :new
    end
  end

  def destroy
    @account = current_user.accounts.find(params[:id])
    if @account.destroy
      redirect_to action: 'index'
    else
      redirect_to action: 'index'
    end
  end

end