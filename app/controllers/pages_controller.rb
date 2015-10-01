class PagesController < ApplicationController
  before_filter :authenticate_admin_user!, only: :admin
  layout 'admin', only: :admin

  def index
  end

  def admin
  end
end
