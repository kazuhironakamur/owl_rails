Rails.application.routes.draw do
  resources :images ,param: :filename do
    member do
      get 'imageonly',to: 'images#imageonly'
    end
  end
  get 'images/search/:code' => 'images#search'

  get 'products/filter' => 'products#filter'
  resources :products
end
