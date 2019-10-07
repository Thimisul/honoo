Rails.application.routes.draw do
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'tipoEvento', to: 'event_types#getEventType'

  post 'user', to: 'users#addUser'
  put 'user', to: 'users#updateUser'
  get 'user', to: 'users#getUserById'
  delete 'user/:id', to: 'users#destroy'
  post 'user/login', to: 'users#login'
 


end
