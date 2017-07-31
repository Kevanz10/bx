class Donation < ApplicationRecord
  # belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  # belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  belongs_to :user
  enum status: { completed: 0, pending: 1 }
end
