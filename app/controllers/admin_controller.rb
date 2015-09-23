class AdminController < ApplicationController
  before_filter :require_admin, only: [:index]
  layout 'admin'

  def index
  end
end
