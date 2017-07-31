Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :donations

  post '/enviar_donacion', to: 'donations#sent_donation', as: 'sent_donation'

end
