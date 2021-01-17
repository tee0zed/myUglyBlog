Rails.application.routes.draw do
  devise_for :users

  constraints !SubdomainRoutes do
    resources :blogs, only: :new
    get '/index', to: 'blogs#index', as: :root
  end

  constraints SubdomainRoutes do
    get '/', to: 'blogs#show', as: :blogs_show
    get '/edit', to: 'blogs#edit', as: :blogs_edit
    patch '/', to: 'blogs#update', as: :blogs_update
    delete '/', to: 'blogs#destroy', as: :blogs_destroy

    resources :posts do
      resources :comments, only: %i[create destroy]
    end
  end
end
