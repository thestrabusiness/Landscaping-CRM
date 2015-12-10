class Payment < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :client
end
