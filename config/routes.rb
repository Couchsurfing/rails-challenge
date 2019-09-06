Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '/api' do
    resources :orders, only: [:index, :show, :create, :update] do
    end

    resources :products do
      resources :variants, only: [:index] do
      end
    end
    resources :customers
    resource :variants, only: [:index, :show] do
    end
  end
end
