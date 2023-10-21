Rails.application.routes.draw do
  scope RailsCom.default_routes_scope do
    namespace :cms, defaults: { business: 'cms' } do
      resources :videos do
        collection do
          get :list
          get :starred
        end
        member do
          patch :viewed
        end
      end
      resources :video_taxons
      resources :video_tags
      resources :audios, only: [:index, :show]
      resources :carousels


      namespace :admin, defaults: { namespace: 'admin' } do
        root 'home#index'
        resources :covers
        resources :videos
        resources :audios
        resources :carousels do
          member do
            patch :reorder
          end
        end
      end
    end
  end
end
