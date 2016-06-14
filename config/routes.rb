Rails.application.routes.draw do
  root to: "scrapbooks#create"
  resources :scrapbooks,
            path: "/",
            only: [:show],
            constraints: { id: Scrapbook::VALID_ID } do
    resource :introduction, only: [:show]
    resource :search, only: [:new, :show]
    resources :occupations, only: [:show, :index], param: :soc_code
    resources :saved_occupations, only: [:create, :destroy], param: :soc_code
    get "/cookies", to: "static_pages#cookies"
    get "*path", to: "errors#not_found"
  end
  get "/cookies", to: "static_pages#cookies"
  get "/404", :to => "errors#not_found"
end
