Naturesoft::Galleries::Engine.routes.draw do
  namespace :backend, module: "backend" do
    resources :images do
      collection do
        put ':id/enable' => 'images#enable', :as => 'enable'
        put ':id/disable' => 'images#disable', :as => 'disable'
        delete 'delete'
      end
    end
    resources :galleries do
      collection do
        put ':id/enable' => 'galleries#enable', :as => 'enable'
        put ':id/disable' => 'galleries#disable', :as => 'disable'
        delete 'delete'
        get "select2"
      end
    end
  end
end