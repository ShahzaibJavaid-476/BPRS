class Feature < ApplicationRecord
  has_many :plan_features, dependent: :destroy
  has_many :plans, through: :plan_features
  has_many :usages, dependent: :destroy

  validates :name, :code, :unit_price, :max_unit_limit, presence: true
  validates :unit_price, numericality: { greater_than: 0 }
  validates :max_unit_limit, numericality: { greater_than_or_equal_to: 0 }
end
