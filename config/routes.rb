Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static#home'
  get '/que_es', to: 'static#que_es'
  get '/como_funciona', to: 'static#como_funciona'
  get '/testimonios', to: 'static#testimonios'
  get '/contacto', to: 'static#contacto'

  devise_for :users, controllers: { registrations: 'registrations' }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :donations

  #custom routes
  post '/enviar_donacion', to: 'donations#sent_donation', as: 'sent_donation'
  post '/requerir_donacion', to: 'requests#request_donation', as: 'request_donation'


end
