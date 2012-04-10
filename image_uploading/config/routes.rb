ImageUploading::Application.routes.draw do
  resources :albums do
    resources :photos, :only => :show
  end

  root :to => 'albums#index'
end
