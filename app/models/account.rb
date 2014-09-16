class Account < ActiveRecord::Base

  belongs_to :user
  has_many :transactions
  has_many :schedules
  has_many :limits

  validates_presence_of :name
  validates_presence_of :user_id

  def income_until(end_date)
    sum = Money.new(0, user.settings(:transactions).currency)
    transactions_until(end_date).each do |t|
      sum += t.income
    end
    sum
  end

  def outcome_until(end_date)
    sum = Money.new(0, user.settings(:transactions).currency)
    transactions_until(end_date).each do |t|
      sum += t.outcome
    end
    sum
  end

  def income_in(year, month)
    end_date = Date.new(year, month, 1)
    end_date = end_date + 1.month - 1.day
    start_date = Date.new(year, month, 1)
    income_until(end_date) - income_until(start_date)
  end

  def outcome_in(year, month)
    end_date = Date.new(year, month, 1)
    end_date = end_date + 1.month - 1.day
    start_date = Date.new(year, month, 1)
    outcome_until(end_date) - outcome_until(start_date)
  end

  def balance_in(year, month)
    end_date = Date.new(year, month, 1)
    end_date = end_date + 1.month - 1.day
    start_date = Date.new(year, month, 1)
    balance_until(end_date) - balance_until(start_date)
  end

  def balance
    income_until(Date.current) - outcome_until(Date.current)
  end

  def static_outcome_in(year, month)
    end_date = Date.new(year, month, 1)
    end_date = end_date + 1.month - 1.day
    start_date = Date.new(year, month, 1)
    static_outcome_until(end_date) - static_outcome_until(start_date)
  end

  def static_outcome_until(end_date)
    sum = Money.new(0, user.settings(:transactions).currency)
    static_transactions_until(end_date).each do |t|
      sum += t.outcome
    end
    sum
  end

  def scheduled_outcome_in(year, month)
    end_date = Date.new(year, month, 1)
    end_date = end_date + 1.month - 1.day
    start_date = Date.new(year, month, 1)
    scheduled_outcome_until(end_date) - scheduled_outcome_until(start_date)
  end

  def scheduled_outcome_until(end_date)
    sum = Money.new(0, user.settings(:transactions).currency)
    scheduled_transactions_until(end_date).each do |t|
      sum += t.outcome
    end
    sum
  end

  def balance_until(end_date)
    income_until(end_date) - outcome_until(end_date)
  end

  def static_transactions_until(end_date)
    transactions.where('accounted_at <= ?', end_date).to_a
  end

  def transactions_until(end_date)
    static_transactions_until(end_date) + scheduled_transactions_until(end_date)
  end

  def scheduled_transactions_until(end_date)
    result = []
    for schedule in schedules
      date = schedule.starting_at
      while date < end_date
        result << schedule.transaction_at(date)
        date += 1.month
      end
    end
    result
  end

  def history_until(end_date)
    events = []
    balance = Money.new(0, user.settings(:transactions).currency)
    transactions_until(end_date).sort{|a,b| a.accounted_at <=> b.accounted_at}.each do |t|
      balance += t.income
      balance -= t.outcome
      events << {balance: balance, date: t.accounted_at, name: t.name}
    end
    events
  end

end
