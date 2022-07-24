Rails.application.routes.draw do
  scope RailsExtend.default_routes_scope do
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
      resources :audios, only: [:index]
      resources :carousels

      namespace :admin, defaults: { namespace: 'admin' } do
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
