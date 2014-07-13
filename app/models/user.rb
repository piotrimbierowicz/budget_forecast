class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :accounts
  has_many :transactions, :through => :accounts
  has_many :schedules, :through => :accounts

  has_settings do |s|
    s.key :transactions, :defaults => { :currency => 'PLN' }
    s.key :locals,  :defaults => { :language => :pl }
  end

end
