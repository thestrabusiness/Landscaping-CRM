class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :invoice_items, dependent: :destroy
  validates :client_id, presence: true
  
  def client_name
  end
  
  def client_name=(name)
  end
  
  def check_balance_forward
    if (client.balance == 0)
      'pos_balance'      
    elsif (balance_forward < 0)
    	'neg_balance'
    else
      'pos_balance'
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
  
  def build_pdf
    path = show_pdf_invoice_url(self)
    filename = "invoice_#{self.id}"
    
    kit = PDFKit.new(path)
    pdf = kit.to_pdf
    send_data(pdf, :filename => filename, :type => 'application/pdf', :disposition => 'inline')
  end
  
end

