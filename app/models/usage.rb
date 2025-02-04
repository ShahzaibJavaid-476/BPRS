class Usage < ApplicationRecord
  belongs_to :subscription
  belongs_to :feature

  validates :units_used, numericality: { greater_than_or_equal_to: 0 }
end
