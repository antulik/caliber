module ActionDispatch::Routing
  class Mapper
    # Includes mount_caliber method for routes. This method is responsible to
    # generate all needed routes for caliber
    def mount_caliber
      get "rails/css" => "caliber/caliber#index"
      mount Caliber::Engine => "/caliber", :as => "caliber_engine"
    end
  end
end
