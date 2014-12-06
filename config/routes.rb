Rails.application.routes.draw do

  get 'atm/index', as: :atm
  post 'atm/authenticate', as: :atm_authenticate
  get 'atm/finish'

  get 'welcome/index', as: :welcome
  root "welcome#index"

end
