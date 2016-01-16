class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :services, dependent: :destroy
  
  def client_last_name
    client.try(:last_name)
  end
  
  def client_last_name=(last_name)
    self.client = Client.find_by_name(last_name) if last_name.present?
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

