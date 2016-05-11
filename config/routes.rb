Rails.application.routes.draw do
  root :to => "welcome#index"

  get "auth/:provider/callback" => "sessions#omniauth_callback"

  get "repositories" => "repositories#index"
  put "repositories/:repository_id/hook" => "repository_hooks#create", :as => :hook
  delete "repositories/:repository_id/hook" => "repository_hooks#destroy"
end
