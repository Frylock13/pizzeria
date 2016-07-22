class ApplicationMailer < ActionMailer::Base
  add_template_helper ApplicationHelper
  append_view_path "#{Rails.root}/app/views/mail/"
  default from: 'VPZven <order@vpzven.ru>'
  layout 'mail/application'
end
