Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"professionals#index" #ruta de inicio
  get "professionals", to:"professionals#index"

  get 'professionals/:id/edit', to: 'professionals#edit'
  patch 'professionals/:id', to: 'professionals#update', as: :professional

  get 'professionals/new', to: 'professionals#new'
  post "professionals", to:'professionals#create'

  #get 'professionals/:id', to: 'professionals#show'
  delete 'professionals/:id', to: 'professionals#destroy'



end
