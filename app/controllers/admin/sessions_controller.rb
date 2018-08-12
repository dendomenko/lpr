module Admin
  class SessionsController < Devise::SessionsController
    layout "admin"
    private

    def after_sign_in_path_for(resource)
      admin_dashboard_index_path
    end
  end
end
