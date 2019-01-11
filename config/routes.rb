Rails.application.routes.draw do

  scope module: 'media' do
    resources :posts
    controller :posts do
      get '/p/:code' => :code, as: :p
    end
  end

  scope :api, module: 'media/api', as: :api do
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

  scope :admin, module: 'media/admin', as: 'admin' do
    resources :posts
    resources :posters
    resources :topics
    resources :videos
  end

end
