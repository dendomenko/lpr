Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  devise_for :user,
    path: 'admin',
    controllers: {
      sessions: 'admin/sessions'
    }

  namespace :admin do
  	root :to => "dashboard#index"
    resources :dashboard, only: %i[index]
  end

  namespace :api do
      namespace :v2 do
        post 'auth_user' => 'authentication#authenticate_user'
        post 'sign_up' => 'authentication#sign_up'
        get 'home' => 'home#index'
        resources :movies, only: %i[index show] do
          post 'rate', on: :member
          delete 'unvote', on: :member
        end
        resources :news, only: %i[index show]
        resources :comments, only: %i[create destroy]
      end
    end

    get '/', to: 'application#index', format: false
    get '/*path', to: 'application#index', format: false
end
