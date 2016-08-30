Naturesoft::Galleries::Engine.routes.draw do
  namespace :admin, module: "admin" do
    resources :images do
      collection do
        put ':id/enable' => 'images#enable', :as => 'enable'
        put ':id/disable' => 'images#disable', :as => 'disable'
      end
    end
    resources :galleries do
      collection do
        put ':id/enable' => 'galleries#enable', :as => 'enable'
        put ':id/disable' => 'galleries#disable', :as => 'disable'
        delete 'delete'
      end
    end
  end
end