class ClientPrice < ActiveRecord::Base
  belongs_to :clients
  belongs_to :services
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      ClientPrice.create! row.to_hash
    end
  end
  
end
