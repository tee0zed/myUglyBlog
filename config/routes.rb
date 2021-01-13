Rails.application.routes.draw do
  devise_for :users
  root 'blogs#index'

  constraints(!SubdomainRoutes) do
    resources :blogs, only: [:new]
  end

  constraints(SubdomainRoutes) do
    resources :blogs, except: [:index, :new] do
      resources :posts do
        resources :comments
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
