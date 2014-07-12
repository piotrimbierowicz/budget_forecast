class Account < ActiveRecord::Base

  belongs_to :user
  has_many :transactions

  validates_presence_of :name
  validates_presence_of :user_id

end
