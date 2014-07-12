class Account < ActiveRecord::Base

  belongs_to :user
  has_many :transactions
  has_many :schedules

  validates_presence_of :name
  validates_presence_of :user_id

  def income
    sum = Money.new(0, 'PLN')
    transactions.each do |t|
      sum += t.income
    end
    sum
  end

  def outcome
    sum = Money.new(0, 'PLN')
    transactions.each do |t|
      sum += t.outcome
    end
    sum
  end

  def balance
    income - outcome
  end

end
