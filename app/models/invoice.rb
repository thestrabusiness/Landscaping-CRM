class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :services, dependent: :destroy
  
  def client_name
#    client.try(:last_name)
  end
  
  def client_name=(name)
#    self.client = Client.find_by(:last_name => lastname) if lastname.present?
  end

  def balance_forward
    if client.balance == 0
      0
    else
      (client.balance - total)
    end
  end

  def invoice_summary
    [date.strftime("%m/%d/%y"), client.last_name, ("$"+total.to_s)].join (' - ')
  end
  
end

