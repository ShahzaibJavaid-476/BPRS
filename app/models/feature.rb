class Feature < ApplicationRecord
  belongs_to :plan

  validates :name, :code, :unit_price, :max_unit_limit, presence: true
  validates :unit_price, numericality: { greater_than: 0 }
  validates :max_unit_limit, numericality: { greater_than_or_equal_to: 0 }
end
