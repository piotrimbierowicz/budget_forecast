class Transaction < ActiveRecord::Base

  monetize :income, :outcome

end
