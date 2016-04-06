class Estimate < ActiveRecord::Base
  belongs_to :client
  has_many :estimate_items
  
  def client_name
  end
  
  def client_name=(name)
  end
  
end
