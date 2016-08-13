class Client < ActiveRecord::Base
  validates :billing_address, :job_address, :city, :zip, presence: true
  
  self.primary_key = 'id'
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :client_prices, dependent: :destroy
  has_many :services, through: :client_prices
  
  searchable do
    text :id
    text :first_name
    text :last_name
    text :job_address
    text :billing_address
    text :city
    string :first_name
    string :last_name
    string :id
  end
  
  def full_name
    [first_name, last_name].each{|e| e.to_s.strip!}.join(' ')
  end
  
  def client_summary
    [full_name, job_address].each{|e| e.to_s.strip!}.join(' - ')
  end    

  def last_payment
    payment = Payment.where(:client_id => id).scoping do
      Payment.last
    end
    if payment == nil
      " "
    else
      payment.amount
    end
  end
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Client.create! row.to_hash
    end
  end
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |client|
        csv << client.attributes.values_at(*column_names)
      end
    end
  end
  
end
