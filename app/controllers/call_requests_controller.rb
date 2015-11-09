class CallRequestsController < ApplicationController
  def new
    @main_menu_key = :new_call_request
    @call_request = CallRequestForm.new(ordering_profile: current_profile).build
    respond_to do |format|
      format.html
      format.js { render :new, layout: false }
    end
    # render :new if stale? [:new_call_request] | layout_resources
  end

  def create
    @call_request = CallRequestForm.new(call_request_params)
    if @call_request.save
      session[:profile_id] = @call_request.ordering_profile.id
      respond_to do |format|
        format.html { redirect_to thanks_call_requests_path, success: 'Ваша заявка успешно отправлена' }
        format.js { render :thanks, layout: false }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js { render :new, layout: false }
      end
      # render :new, change: :new_call_request, layout: !request.xhr?
    end
  end

  private

  def call_request_params
    params.require(:call_request).permit(:first_name, :phone, :wishes).merge(ordering_profile: current_profile)
  end
end
