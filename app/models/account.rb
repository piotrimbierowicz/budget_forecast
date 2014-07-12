class Account < ActiveRecord::Base

  belongs_to :user
  has_many :transactions
  has_many :schedules

  validates_presence_of :name
  validates_presence_of :user_id

  def income_until(end_date)
    sum = Money.new(0, 'PLN')
    transactions_until(end_date).each do |t|
      sum += t.income
    end
    sum
  end

  def outcome_until(end_date)
    sum = Money.new(0, 'PLN')
    transactions_until(end_date).each do |t|
      sum += t.outcome
    end
    sum
  end

  def balance
    income_until(Date.current) - outcome_until(Date.current)
  end

  def balance_until(end_date)
    income_until(end_date) - outcome_until(end_date)
  end

  def transactions_until(end_date)
    result = []
    result += transactions.where('accounted_at <= ?', end_date).to_a
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
    balance = Money.new(0, 'PLN')
    transactions_until(end_date).sort{|a,b| a.accounted_at <=> b.accounted_at}.each do |t|
      balance += t.income
      balance -= t.outcome
      events << {balance: balance, date: t.accounted_at}
    end
    events
  end

end
