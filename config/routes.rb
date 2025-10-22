Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :posts do
        resources :comments, only: [:index, :create]
      end
      resources :comments, only: [:show, :update, :destroy]

      # EXTRA (+20): tags (will work after step 4)
      resources :tags
      post   "posts/:id/tags/:tag_id", to: "posts#add_tag"
      delete "posts/:id/tags/:tag_id", to: "posts#remove_tag"
    end
  end
end
