Rails.application.routes.draw do
  get "rails/info/css" => "caliber/caliber#index"
  get "rails/info/css_nested" => "caliber/caliber#nested"
  mount Caliber::Engine => "/caliber", :as => "caliber_engine"
end
