Rails.application.routes.draw do
  resources :todos
  root "app#app"
end
