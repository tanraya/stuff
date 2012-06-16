FilesUploading::Application.routes.draw do
  resources :uploads
  resources :attachments, :only => [:index, :create, :destroy]
  
  root :to => 'uploads#index'
end
