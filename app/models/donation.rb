class Donation < ApplicationRecord
  # belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  # belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  belongs_to :user
  has_many :transactions, dependent: :destroy
  enum status: { pending: 0, completed: 1 }
end
