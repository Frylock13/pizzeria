class Web::Admin::PagesController < Web::Admin::ApplicationController
  before_action :menu_key
  helper_method :pages

  def index
  end

  def new
    @page = Page.new(viewable_resource: ViewableResource.new)
  end

  def edit
    @page = Page.find(params[:id])
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

  private

  def menu_key
    @menu_key = :pages
  end

  def pages
    @pages ||= Page.all.includes(:viewable_resource)
  end

  def page_params
    params.require(:page).permit(
      :slug,
      viewable_resource_attributes: [:id, :anchor, :meta_keywords, :meta_title,
                                     :page_title, :page_annotation, :page_description]
    )
  end
end
