class Request < ApplicationRecord
  
  has_many :transfers
  belongs_to :user

  enum status: { pending: 0, completed: 1 }
end
