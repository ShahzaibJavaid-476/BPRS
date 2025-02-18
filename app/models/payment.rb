class Payment < ApplicationRecord
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id' 
  belongs_to :plan

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[success failed pending] }
  validates :transaction_id, presence: true, uniqueness: true
end
