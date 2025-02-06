class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { admin: 'admin', buyer: 'buyer' }

  validates :name, presence: true

  has_many :subscriptions, foreign_key: :buyer_id, dependent: :destroy
  has_many :plans, through: :subscriptions
  
  #def subscribed_to?(plan)
    #plans.exists?(plan.id)
  #end
end