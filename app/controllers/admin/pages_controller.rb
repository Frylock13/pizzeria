module Admin
  class PagesController < AdminController
    before_action :main_menu_key
    helper_method :pages

    def index
      # render :index if stale? @pages | layout_resources
    end

    def new
      @page = Page.new(viewable_resource: ViewableResource.new)
      # render :new if stale? [@page] | layout_resources
    end

    def edit
      @page = Page.find(params[:id])
      # render :edit if stale? [@page] | layout_resources
    end

    def create
      @page = Page.new(page_params)
      if @page.save
        redirect_to [:edit, :admin, @page], success: 'Страница успешно добавлена'
      else
        render :new, change: :new_page, layout: !request.xhr?
      end
    end

    def update
      @page = Page.find(params[:id])
      if @page.update(page_params)
        redirect_to [:edit, :admin, @page], success: 'Страница успешно обновлена'
      else
        render :edit, change: "edit_page_#{@page.id}", layout: !request.xhr?
      end
    end

    def destroy
      @page = Page.find(params[:id])
      if @page.destroy
        flash[:success] = 'Страница успешно удалена'
      else
        flash[:success] = 'Невозможно удалить страницу'
      end
      redirect_to admin_pages_path, change: :pages
    end

    def dashboard
      @main_menu_key = :dashboard
      # render :dashboard if stale? [:admin_dashboard] | layout_resources
    end

    private

    def main_menu_key
      @main_menu_key = :pages
    end

    def pages
      @pages ||= Page.all.includes(:viewable_resource)
    end

    def page_params
      params.require(:page).permit(
        :slug,
        { viewable_resource_attributes: [:id, :anchor, :meta_keywords, :meta_title,
                                         :page_title, :page_annotation, :page_description] }
      )
    end
  end
end
