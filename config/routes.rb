Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static#home'
  
  devise_for :users, controllers: { registrations: 'registrations' }
    
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :donations

  post '/enviar_donacion', to: 'donations#sent_donation', as: 'sent_donation'


end
