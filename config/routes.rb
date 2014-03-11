Rails.application.routes.draw do
  get "rails/info/css" => "caliber/caliber#index"
  mount Caliber::Engine => "/caliber", :as => "caliber_engine"
end
