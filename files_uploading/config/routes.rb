FilesUploading::Application.routes.draw do
  resources :uploads
  resources :attachments, :only => [:index, :create, :update, :destroy] do
    get 'attachable/:attachable_type/:attachable_id' => 'attachments#attachable',
      :on => :collection,
      :as => :attachable
  end
  put '/attachments' => 'attachments#create', :as => :attachments
  
  root :to => 'uploads#index'
end
