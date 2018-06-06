module Admin
  class BaseController < ActionController::Base
    # include Pundit
    # protect_from_forgery

    before_action :authenticate_user!
    before_action :authorize_user!

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    protected

    def authorize_user!
      unless current_user&.admin?
        raise Pundit::NotAuthorizedError,
              "Must be logged in and must be an admin"
      end
    end

    def authorize(record, query = nil)
      super([:admin, record], query)
    end

    def policy_scope(scope)
      super([:admin, scope])
    end

    def filter_params
      params.slice(:simple_search)
    end

    private

    def user_not_authorized
      redirect_to(request.referrer || [:root])
    end
  end
end
