CowpuAmerine::Application.routes.draw do
  resources :members do
    get 'signup', :on => :collection
  end
  root :to => "pages#index"
end
