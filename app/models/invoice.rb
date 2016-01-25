class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :services, dependent: :destroy
  
  def client_lastname
    client.try(:last_name)
  end
  
  def client_lastname=(lastname)
    self.client = Client.find_by(:last_name => lastname) if lastname.present?
  end
  
  def client_id
    client.try(:client_id)
  end
  
  def client_id=(lastname)
    self.client = Client.where(:last_name => lastname) if lastname.present?
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

