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

end