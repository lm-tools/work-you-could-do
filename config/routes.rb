Rails.application.routes.draw do
  root to: "scrapbooks#create"
  resources :scrapbooks,
            path: "/",
            only: [:show],
            constraints: { id: Scrapbook::VALID_ID } do
    resource :search, only: [:new, :show]
    resources :occupations, only: [:show, :index], param: :soc_code
    resources :saved_occupations, only: [:create, :destroy], param: :soc_code
  end
end
