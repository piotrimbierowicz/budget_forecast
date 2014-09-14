class TransactionsController < FrontController

  def update
    transaction = current_user.transactions.find(params[:id])
    if transaction.update_attributes(params.require(:transaction).permit(:name, :income, :outcome, :income_currency, :outcome_currency, :accounted_at))
      flash[:notice] = I18n.t 'activerecord.update_success.tranaction'
      redirect_to account_path(transaction.account)
    else
      flash[:notice] = I18n.t 'activerecord.update_fail.tranaction'
      redirect_to account_path(transaction.account)
    end
  end

  def destroy
    transaction = current_user.transactions.find(params[:id])
    account = transaction.account
    if transaction.destroy
      redirect_to account_path(account)
    else
      redirect_to account_path(account)
    end
  end

  def create
    @transaction = Transaction.new(params.require(:transaction).permit(:name, :income, :outcome, :income_currency, :outcome_currency, :accounted_at))
    @accounts = current_user.accounts
    account = @accounts.find(params[:transaction][:account_id])
    @transaction.account_id = account.id
    if @transaction.save
      flash[:notice] = I18n.t 'activerecord.create_success.tranaction'
      redirect_to account_path(@transaction.account)
    else
      flash[:notice] = I18n.t 'activerecord.create_fail.tranaction'
      render :new
    end
  end

  def new
    @transaction = Transaction.new(:accounted_at => Date.current)
    @accounts = current_user.accounts
  end

end