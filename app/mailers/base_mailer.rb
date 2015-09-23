class BaseMailer < ActionMailer::Base
  add_template_helper ApplicationHelper
  append_view_path "#{Rails.root}/app/views/mailers/"
  default from: 'VPZven <order@vpzven.ru>'
  layout 'mail'
end
