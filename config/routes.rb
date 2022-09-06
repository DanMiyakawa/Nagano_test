Rails.application.routes.draw do

  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  root to: 'homes#top'
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }



  namespace :public do
    root to: 'homes#top'
    get 'homes/about', as: 'about'
    resources :customers, only: [:show, :edit, :update]
    # 退会確認画面
    get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    resources :items, only: [:show, :index]
    resources :cart_items, only: [:index, :create, :destroy, :update] do
      delete "/cart_items/destroy_all" => "cart_items#destroy_all"
    end
    resources :shipping_addresses, only: [:index, :edit, :update, :create, :destroy]
    get "/orders/thanks" => "orders#thanks"
    post "/orders/confirm" => "orders#confirm"
    resources :orders, only: [:index, :new, :create, :show]
  end

  namespace :admin do
    resources :items, only: [:show, :index, :new, :edit, :create, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
