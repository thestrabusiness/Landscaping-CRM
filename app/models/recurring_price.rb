class RecurringPrice < ActiveRecord::Base
  belongs_to :clients
  belongs_to :recurring_services
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      RecurringPrice.create! row.to_hash
    end
  end
  
end
