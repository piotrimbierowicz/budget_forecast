class Schedule < ActiveRecord::Base

  monetize :income_cents, with_model_currency: :income_currency
  monetize :outcome_cents,  with_model_currency: :outcome_currency

  belongs_to :account

  validates_presence_of :name
  validates_presence_of :starting_at
  validates_presence_of :account_id

  FREQUENCIES = [Monthly = 'monthly']

end
