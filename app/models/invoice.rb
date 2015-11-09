class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :services, dependent: :destroy
  
  def set_sent
  end
  
  def set_paid
  end
  
  def show_pdf
  end
  
end

