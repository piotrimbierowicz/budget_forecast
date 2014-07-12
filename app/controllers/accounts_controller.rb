class AccountsController < FrontController

  def index
    @accounts = current_user.accounts
  end

  def new
    @account = Account.new
  end

  def show
    @account = current_user.accounts.find(params[:id])
    @new_transaction = Transaction.new
    @new_schedule = Schedule.new
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

  def create_transaction
    @account = current_user.accounts.find(params[:id])
    @new_transaction = Transaction.new(params.require(:transaction).permit(:name, :income, :outcome, :income_currency, :outcome_currency, :accounted_at))
    @new_transaction.account = @account
    if @new_transaction.save
      redirect_to action: 'show', :id => @account.id
    else
      @new_schedule = Schedule.new
      render :show
    end
  end

  def create_schedule
    @account = current_user.accounts.find(params[:id])
    @new_schedule = Schedule.new(params.require(:schedule).permit(:name, :income, :outcome, :income_currency, :outcome_currency, :starting_at, :frequency))
    @new_schedule.account = @account
    if @new_schedule.save
      redirect_to action: 'show', :id => @account.id
    else
      @new_transaction = Transaction.new
      render :show
    end
  end

end