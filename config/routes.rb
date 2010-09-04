CowpuAmerine::Application.routes.draw do
  resources :members do
    get 'signup', :on => :collection
  end
  
  get 'meetings', :to => "pages#meetings"
  root :to => "pages#index"
end
