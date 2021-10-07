Rails.application.routes.draw do

  namespace :cms, defaults: { business: 'cms' } do
    resources :videos, on: [:show]

    scope :api, module: 'media/api', as: :api do
      resources :videos do
        get :list, on: :collection
        get :starred, on: :collection
        patch :viewed, on: :member
      end
      resources :video_taxons
      resources :video_tags
      resources :audios, only: [:index]
    end

    namespace :admin, defaults: { namespace: 'admin' } do
      resources :videos
      resources :audios
    end
  end

end
