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
  resources :services
  
  resources :clients do
    member do
      get :reminder
    end

    collection do
      post :import
      get :summary
      get :generate_reminders
    end
    
    resources :client_prices, except: [:index], controller: 'clients/client_prices' do
      collection { post :import }
    end
    
  end
  
  resources :invoices do
    resources :invoice_items, except: [:index], controller: 'invoices/invoice_items'
    member do
      put :set_sent
      put :set_paid
      get :show_pdf
      get :generate_pdf
    end
    collection do
      get :generate_multiple_pdfs
      get :labels
    end
  end
  
  resources :client_prices, controller: 'clients/client_prices' do
    collection { post :import }
  end
  
end
