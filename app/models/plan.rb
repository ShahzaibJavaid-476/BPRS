class Plan < ApplicationRecord
  belongs_to :admin, class_name: 'User'

  has_many :plan_features, dependent: :destroy
  has_many :features, through: :plan_features
  has_many :subscriptions, dependent: :destroy
  has_many :buyers, through: :subscriptions, source: :buyer

  validates :name, presence: true, uniqueness: true
  validates :monthly_fee, numericality: { greater_than_or_equal_to: 0 }  
end
