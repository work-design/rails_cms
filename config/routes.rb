Rails.application.routes.draw do

  scope module: 'cms' do
    resources :posts
    controller :posts do
      get '/p/:code' => :code, as: :p
    end
  end

  scope :api, module: 'cms/api', as: :api do
    resources :videos do
      patch :viewed, on: :member
    end
    resources :video_taxons
    resources :video_tags
    resources :topics
    resources :posts, except: [:new, :edit] do
      post :star, on: :member
      delete 'star' => :cancel_star, on: :member
    end
    resources :posters, only: [:index, :show]
  end

  scope :admin, module: 'cms/admin', as: 'admin' do
    resources :posts
    resources :posters
    resources :topics
    resources :videos
    resources :tags
    resources :taxons
  end

end
