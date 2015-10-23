class PagesController < ApplicationController
  def show
    @main_menu_key = "page_#{params[:id]}"
    @page = params[:id]
  end
end
