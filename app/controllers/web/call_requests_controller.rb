# == Schema Information
#
# Table name: call_requests
#
#  id                   :integer          not null, primary key
#  ordering_profile_id  :integer
#  wishes               :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  receiving_profile_id :integer
#

class Web::CallRequestsController < Web::ApplicationController
  def new
    @menu_key = :new_call_request
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
      SmsWorker.perform_async(ENV['APP_PHONE'], "Заявка на обратный звонок: #{@call_request.call_request.receiving_phone}, #{@call_request.call_request.receiving_first_name}")
      respond_to do |format|
        format.html { redirect_to thanks_call_requests_path, success: 'Ваша заявка успешно отправлена' }
        format.js { render :thanks, layout: false }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js { render :new, layout: false }
      end
    end
  end

  def thanks
  end

  private

  def call_request_params
    params.require(:call_request).permit(:first_name, :phone, :wishes).merge(ordering_profile: current_profile)
  end
end
