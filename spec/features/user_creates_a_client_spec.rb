require 'rails_helper.rb'

feature 'Client creation' do
  scenario 'Creating a valid client' do
    client = build(:client)
    
    user = create(:user)
    user.confirm
    login(user)
    
    click_link('Add New Client')
    save_and_open_page
    
    fill_in('client_first_name', with: client.first_name)
    fill_in('client_last_name', with: client.last_name)
    fill_in('client_billing_address', with: client.billing_addres)
    fill_in('client_job_address', with: client.job_address)
    fill_in('client_city', with: client.city)
    fill_in('client_state', with: client.state)
    fill_in('client_zip', with: client.zip)
    
    click_on 'Create Client'
    
    expect(page).to have_content('Client was successfully created.')
    
  end
end

    
def login(user)
  visit(root_path)
  fill_in('user_email', with: user.email)
  fill_in('user_password', with: 'password')
  click_on 'Log in'
end    
    
  