class Subscription < ApplicationRecord
  belongs_to :buyer, class_name: 'User'
  belongs_to :plan
  has_many :usages, dependent: :destroy
  has_many :invoices, dependent: :destroy

  validates :billing_day, presence: true, inclusion: { in: 1..30 }, allow_nil: true
  validates :plan_id, presence: true
end

