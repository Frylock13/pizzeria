class Web::Admin::ApplicationController < Web::ApplicationController
  before_filter :require_admin

  # private

  # def layout_resources
  #   [revision]
  # end
end
