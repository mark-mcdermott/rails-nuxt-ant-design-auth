class Budget < ApplicationRecord
  belongs_to :user
  has_one :purchase_type
end
