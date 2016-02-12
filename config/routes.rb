Rails.application.routes.draw do
  root 'searches#new'
  resource :search, only: [:show]
  resources :occupations, only: [:show, :index], param: :soc_code
end
