Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root to: 'homes#top'
  get 'homes/about', as: 'about'

  namespace :public do
    resources :customers, only: [:show, :edit, :update]
    # 退会確認画面
    get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    resources :items, only: [:show, :index]
    resources :cart_items, only: [:index, :create, :destroy, :update] do
      delete "/cart_items/destroy_all" => "cart_items#destroy_all"
    end
    resources :addresses, only: [:index, :edit, :update, :create, :destroy]
  end

  namespace :admin do
    resources :items, only: [:show, :index, :new, :edit, :create, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
