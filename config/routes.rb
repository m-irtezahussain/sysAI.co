Rails.application.routes.draw do

  root "hero#index"

  get '/session/admin', to: 'session#AdminLogin', as: 'admin_session'
  post '/session/admin', to: 'session#AdminLogin'
  delete 'logout', to: 'session#AdminDestroy'
  get '/session/admin/register', to:'session#new', as: 'admin_create'
  post '/session/admin/register', to: 'session#create'

  get '/admin/register_business', to: 'business#new', as: 'business_registration'
  post '/admin/register_business', to: 'business#create'


  get '/dashboard_main', to: 'dashboard#main', as: 'dashboard'
  get '/work', to: 'dashboard#work'

  
end
