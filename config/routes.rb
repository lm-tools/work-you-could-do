Rails.application.routes.draw do
  root 'searches#new'
  resource :search, only: [:show]
end
