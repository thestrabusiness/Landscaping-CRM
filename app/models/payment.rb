class Payment < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :client
  validates :invoice_id, :client_id, presence: true
  
  def select_invoice
  end
  
  def client_name
  end
  
  def client_name=(name)
  end
  
end
