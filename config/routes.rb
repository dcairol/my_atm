Rails.application.routes.draw do

  get 'atm/index', as: :atm
  post 'atm/authenticate', as: :atm_authenticate
  post 'atm/finish', as: :finish
  post 'atm/withdraw', as: :withdraw

  get 'welcome/index', as: :welcome
  root "welcome#index"

end
