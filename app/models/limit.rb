class Limit < ActiveRecord::Base

  PERIODS = [Monthly = 'monthly']

  monetize :value_cents, with_model_currency: :value_currency

  belongs_to :account
  validates_presence_of :account
  validates_presence_of :period
  validates_presence_of :value

  def current_month_spendings_value
    self.account.static_outcome_in(Date.current.year, Date.current.month)
  end

  def current_month_schedules_value
    self.account.scheduled_outcome_in(Date.current.year, Date.current.month)
  end

  def current_month_limit_left
    self.value - self.current_month_schedules_value - self.current_month_spendings_value
  end

  def current_month_daily_limit
    left_days = (Date.current.end_of_month - Date.current).to_i
    current_month_limit_left / left_days
  end

  def current_month_primary_daily_limit
    left_days = (Date.current.end_of_month - Date.current.beginning_of_month).to_i
    (self.value - current_month_schedules_value) / left_days
  end

  def current_month_daily_balance
    current_month_daily_limit - current_month_primary_daily_limit
  end

  def current_month_monthly_balance
    days = (Date.current - Date.current.beginning_of_month).to_i
    current_month_daily_balance * days
  end

end
