class PagesController < ApplicationController
  def show
    @main_menu_key = "page-#{params[:id]}"
    @page = Page.find(params[:id])
    # render :show if stale? [@page] | layout_resources
  end
end
