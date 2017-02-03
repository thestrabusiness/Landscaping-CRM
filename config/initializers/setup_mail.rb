ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address                    => 'smtp.gmail.com',
  :port                       => '587',
  :authentication             => :plain,
  :user_name                  => 'moffalandscapemailer@gmail.com',
  :password                   => 'x6MwMXjFmTbP',
  :domain                     =>  'gmail.com',
  :enable_starttls_auto       => true
}

  
