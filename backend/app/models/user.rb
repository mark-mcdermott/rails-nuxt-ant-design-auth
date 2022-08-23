class User < ApplicationRecord
  devise :database_authenticatable, 
         :registerable,
         :jwt_authenticatable, 
         jwt_revocation_strategy: JwtDenylist
  has_many :accounts
  has_many :budgets
  has_many :transactions
end