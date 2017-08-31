class Transaction < ApplicationRecord
  belongs_to :donation
  belongs_to :request
end
