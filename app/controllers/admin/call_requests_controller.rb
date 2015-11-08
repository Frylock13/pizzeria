module Admin
  class CallRequestsController < AdminController
    def index
      @main_menu_key = :call_requests
      @call_requests = CallRequest.all.order(created_at: :desc)
      # render :index if stale? @call_requests | layout_resources
    end

    def destroy
      @call_request = CallRequest.find(params[:id])
      if @call_request.destroy
        flash[:success] = 'Заявка на звонок успешно удалена'
      else
        flash[:success] = 'Невозможно удалить заявку на звонок'
      end
      redirect_to admin_call_requests_path, change: :call_requests
    end
  end
end
