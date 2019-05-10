Rails.application.routes.draw do
  get '/about', to: 'pages#about'
  devise_for :users
  resources :users do
    resources :projects do
      resources :bugs
    end
  end
    root "bugs#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
