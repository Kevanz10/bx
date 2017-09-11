class Transaction < ApplicationRecord
  belongs_to :donation
  belongs_to :request
  mount_uploader :invoice, InvoiceUploader
end
