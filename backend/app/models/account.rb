class Account < ApplicationRecord
  has_one :account_types
  belongs_to :user
end
