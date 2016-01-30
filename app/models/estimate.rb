class Estimate < ActiveRecord::Base
  belongs_to :client
  has_many :estimate_items
end
