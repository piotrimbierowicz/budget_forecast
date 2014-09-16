class Limit < ActiveRecord::Base

  PERIODS = [Monthly = 'monthly']

  monetize :value_cents

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

end
