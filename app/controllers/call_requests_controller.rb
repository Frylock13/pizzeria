class CallRequestsController < ApplicationController
  def new
    @main_menu_key = :new_call_request
    @call_request = CallRequest.new(profile: current_profile)
    # render :new if stale? [:new_call_request] | layout_resources
  end

  def create
    @call_request = CallRequest.new(call_request_params)
    if @call_request.save
      redirect_to root_path, success: 'Ваша заявка успешно отправлена'
    else
      render :new, change: :new_call_request, layout: !request.xhr?
    end
  end

  private

  def call_request_params
    params.require(:call_request).permit(
      :wishes,
      { profile_attributes: [:id, :first_name, :phone] }
    )
  end
end
