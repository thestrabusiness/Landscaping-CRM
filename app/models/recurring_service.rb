class RecurringService < ActiveRecord::Base
  has_many :recurring_prices, dependent: :destroy
  has_many :clients, through: :recurring_prices
end
