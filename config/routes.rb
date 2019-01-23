Rails.application.routes.draw do

  scope module: 'media' do
  end

  scope :api, module: 'media/api', as: :api do
    resources :videos do
      get :list, on: :collection
      patch :viewed, on: :member
    end
    resources :video_taxons
    resources :video_tags
    resources :audios, only: [:index]
  end

  scope :admin, module: 'media/admin', as: 'admin' do
    resources :videos
    resources :audios
  end

end
