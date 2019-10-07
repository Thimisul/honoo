Rails.application.routes.draw do
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'tipoEvento', to: 'event_types#getEventType'

  post 'user', to: 'users#addUser'
  put 'user', to: 'users#update'
  get 'user/:id', to: 'users#show'
  delete 'user/:id', to: 'users#destroy'
  post 'user/login', to: 'users#login'

  post 'event', to: 'events#addEvent'
  put 'event', to: 'events#updateEvent'
  get 'event', to: 'events#getEvent'
  get 'event/search', to: 'events#searchEvent'
  get 'event/:id', to: 'events#getEventById'
  delete 'event/:id', to: 'events#destroy'
 

end
