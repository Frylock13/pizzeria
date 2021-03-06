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
    @call_request = CallRequestForm.new(ordering_profile: current_profile).build
    respond_to do |format|
      format.html
      format.js { render :new, layout: false }
    end
  end

  def create
    @call_request = CallRequestForm.new(call_request_params)
    if @call_request.save
      session[:profile_id] = @call_request.ordering_profile.id
      SmsCService.new(ENV['APP_PHONE'], "Заявка на обратный звонок: #{@call_request.call_request.receiving_phone}, #{@call_request.call_request.receiving_first_name}").send
      # SmsWorker.perform_async(ENV['APP_PHONE'], "Заявка на обратный звонок: #{@call_request.call_request.receiving_phone}, #{@call_request.call_request.receiving_first_name}")
      respond_to do |format|
        format.html { redirect_to @call_request, success: 'Ваша заявка успешно отправлена' }
        format.js { render :show, layout: false }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js { render :new, layout: false }
      end
    end
  end

  def show
  end

  private

  def call_request_params
    params.require(:call_request).permit(:first_name, :phone, :wishes).merge(ordering_profile: current_profile)
  end
end
