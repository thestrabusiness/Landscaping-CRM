class Payment < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :client
  
  def client_name
  end
  
  def client_name=(name)
  end
  
end
