FactoryGirl.define do
  
  factory :client do
    first_name      'Anthony'
    last_name       'Moffa'
    billing_address '24 Marion Road'
    job_address     '24 Marion Road, Belmont, MA'
    city            'Belmont'
    state           'MA'
    zip             '02478'
    balance         1500
    phone_number    '978-766-3585'
  end
    
end
