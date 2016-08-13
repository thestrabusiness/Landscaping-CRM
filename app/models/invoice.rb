class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :services, dependent: :destroy
  validates :client_id, presence: true
  
  def client_name
  end
  
  def client_name=(name)
  end
  
  def check_balance_forward
    if client.balance == 0
      0
    elsif (client.balance - total < 0)
    	1
    else
      2
    end
  end

  def balance_forward
    if client.balance == 0
      0
    else
      (client.balance - total)
    end
  end
		
	def amount_due
    total + balance_forward
  end

  def invoice_summary
    [date.strftime("%m/%d/%y"), client.last_name, ("$"+total.to_s)].join (' - ')
  end
  
end

