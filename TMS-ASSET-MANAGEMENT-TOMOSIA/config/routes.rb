Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations] 
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
      patch 'users' => 'devise/registrations#update', :as => 'user_registration'
  end


  match '/admin/requests/reject' => 'admin/requests#requests_rejected', :as => 'admin_requests_reject', :via => :get
  match '/admin/items/export_stock' => 'admin/items#export_csv_stock', :as => 'admin_item_export_stock', :via => :get
  match '/admin/items/export_broken' => 'admin/items#export_csv_broken', :as => 'admin_item_export_broken', :via => :get
  match '/admin/items/export_total_items' => 'admin/items#export_csv_total_item', :as => 'admin_item_export_total_items', :via => :get

  resources :users
  resources :items
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  match '/manager/devices/export_stock' => 'manager/devices#export_csv_stock', :as => 'manager_item_export_stock', :via => :get
  match '/manager/devices/export_broken' => 'manager/devices#export_csv_broken', :as => 'manager_item_export_broken', :via => :get

  match '/employee/requests/change_select' => 'employee/requests#change_select', :as => 'employee_request_change_select', :via => :get

  namespace :employee do
    resources :requests
    resources :profiles
  end

  namespace :admin do
    resources :requests
    resources :employees, :controller => 'employees'
    resources :items
    resources :dashboards
    resources :delivers, only: [:index]
  end

  namespace :manager do
    resources :items
    resources :deliver_alls
    resources :delivers
    resources :devices
  end
end
