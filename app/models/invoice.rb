class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :services, dependent: :destroy
  
  def client_name
    client.try(:last_name)
  end
  
  def client_name=(name)
    self.client = Client.find_by(:last_name => lastname) if lastname.present?
  end
      
  def set_sent
  end
  
  def set_paid
  end
  
  def show_pdf
  end
  
  def generate_pdf
  end
  
end

