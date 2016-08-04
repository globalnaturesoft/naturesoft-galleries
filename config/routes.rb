Naturesoft::Core::Engine.routes.draw do
  scope module: 'galleries' do
    namespace :admin, module: "admin" do
      resources :images
      resources :galleries
    end
  end
end