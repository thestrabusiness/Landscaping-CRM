source 'https://rubygems.org'



gem 'rails', '5.0.1'
gem 'raindrops', '0.16.0'
gem 'rake', '10.5.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'pg' # postgres gem
gem 'bootstrap-sass' # Bootstrap for easy style development
gem 'pdfkit'  # pdfkit to generate client invoices from html of invoice views --REQUIRES WKHTMLTOPDF--
gem 'unicorn', '5.0.1'  # use unicorn because pdfkit hangs if you use webrick
gem 'combine_pdf' # use combine_pdf to combine generated pdfs into single file for easier handling
gem 'sunspot_rails' # sunspot search
gem 'sunspot_solr' #solr distribution for sunspot
gem 'will_paginate' #for pagination of search results and client/invoice/payment/etc lists
gem 'rails4-autocomplete' #autocomplete function for search fields
gem 'devise'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  
  #testing suite
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  
end

