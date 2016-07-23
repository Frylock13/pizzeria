class Web::Admin::CallRequestsController < Web::Admin::ApplicationController
  def index
    @menu_key = :call_requests
    @call_requests = CallRequest.all.includes(:ordering_profile, :receiving_profile).order(created_at: :desc)
  end
end
