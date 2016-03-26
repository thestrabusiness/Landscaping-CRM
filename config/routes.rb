Rails.application.routes.draw do
  
  
  devise_for :users
  
  devise_scope :user do
    authenticated do
      root to: "clients#index"
    end
    
    unauthenticated do
      root to: 'devise/sessions#new', as: 'unauthenticated_root'
    end
  end
  
  resources :estimates do
    resources :estimate_items, except: [:index], controller: 'estimates/estimate_items'
    member do
      get :estimate_pdf
      get :view_estimate_pdf
    end
    collection { get :generate_estimate_pdfs }
  end
  
  resources :payments
  resources :recurring_services
  
  resources :clients do
    resources :recurring_prices, except: [:index], controller: 'clients/recurring_prices' do
      collection { post :import }
    end
  end
  
  resources :invoices do
    resources :services, except: [:index], controller: 'invoices/services'
    member do
      put :set_sent
      put :set_paid
      get :show_pdf
      get :generate_pdf
    end
    collection { get :generate_multiple_pdfs }
  end
    
  resources :clients do
    collection { post :import }
  end
  
  resources :recurring_prices, controller: 'clients/recurring_prices' do
    collection { post :import }
  end
  
end
