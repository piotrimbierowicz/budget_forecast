class SchedulesController < FrontController

  def destroy
    schedule = current_user.schedules.find(params[:id])
    account = schedule.account
    if schedule.destroy
      redirect_to account_path(account)
    else
      redirect_to account_path(account)
    end
  end

end