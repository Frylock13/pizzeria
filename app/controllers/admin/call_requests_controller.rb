module Admin
  class CallRequestsController < AdminController
    def index
      @main_menu_key = :call_requests
      @call_requests = CallRequest.all.order(created_at: :desc)
      # render :index if stale? @call_requests | layout_resources
    end
  end
end
