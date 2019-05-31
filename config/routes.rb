Rails.application.routes.draw do
root "projects#index"
  devise_for :users
  resources :users do
    resources :projects do
      resources :bugs
    end
  end
  get '/about', to: 'pages#about'
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
