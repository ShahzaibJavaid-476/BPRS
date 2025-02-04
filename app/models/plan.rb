class Plan < ApplicationRecord
    belongs_to :admin, class_name: 'User'
    has_many :subscriptions
    has_many :buyers, through: :subscriptions
    has_many :features, dependent: :destroy

    validates :name, presence: true, uniqueness: true
    validates :monthly_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
