Rails.application.routes.draw do
  resources :universidades, only: [:index, :show, :create, :update, :destroy]
  resources :unidades, only: [:index, :show, :create, :update, :destroy]
  resources :cursos, only: [:index, :show, :create, :update, :destroy]
  resources :turmas, only: [:index, :show, :create, :update, :destroy]
  resources :disciplinas, only: [:index, :show, :create, :update, :destroy]
  resources :tokens, only: [:create]
  mount_devise_token_auth_for 'User', at: '/auth'
end
