class PagesController < ApplicationController
  def show
    @main_menu_key = "page_#{params[:id]}"
    @page = params[:id]
    if stale?(params[:id])
      render :show
    end
  end
end
