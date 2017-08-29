class Request < ApplicationRecord
  
  has_many :transactions
  belongs_to :user
  enum status: { pending: 0, completed: 1 }
end
