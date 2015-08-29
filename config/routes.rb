Rails.application.routes.draw do
  resources :services
  resources :invoices
  resources :clients
  root "clients#index"
end
