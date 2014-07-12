class TransactionsController < FrontController

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