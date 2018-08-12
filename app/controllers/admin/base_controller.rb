module Admin
  class BaseController < ActionController::Base
  	layout "admin"
    include Pundit
    protect_from_forgery

    before_action :authenticate_user!
    before_action :authorize_user!

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    protected

    def authorize_user!
      unless current_user&.admin?
        raise Pundit::NotAuthorizedError
      end
    end

    def authorize(record, query = nil)
      super([:admin, record], query)
    end

    def policy_scope(scope)
      super([:admin, scope])
    end

    private

    def user_not_authorized
      sign_out current_user if current_user
      redirect_to(new_user_session_path)
    end
  end
end
