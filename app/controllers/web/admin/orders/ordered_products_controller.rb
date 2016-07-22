class Web::Admin::Orders::OrderedProductsController < Web::Admin::Orders::ApplicationController
  helper_method :product_categories

  def new
  end

  def create
    price = order.price
    ordered_product = order.ordered_products.includes(:ordered_product_features)
      .where(product_id: params[:product_id])
      .where('ordered_product_features.product_feature_id': params[:product_feature_id])
      .first_or_initialize
    if ordered_product.new_record? && params[:product_feature_id].present?
      ordered_product.ordered_product_features
                     .build(product_feature_id: params[:product_feature_id])
    end
    ordered_product.quantity += 1
    if ordered_product.save
      BonusPointsRecalculationService.new(order, price).recalculate
      flash[:success] = 'Товар успешно добавлен'
    else
      flash[:error] = 'Невозможно добавить товар'
    end
    redirect_to [:admin, order]
  end

  def destroy
    price = order.price
    if ordered_product.destroy
      BonusPointsRecalculationService.new(order, price).recalculate
      flash[:success] = 'Товар успешно удален'
    else
      flash[:success] = 'Невозможно удалить товар'
    end
    redirect_to [:admin, order]
  end

  private

  def product_categories
    @product_categories ||= ProductCategory.all
      .includes(products: [:features, { product_features: [:feature, :feature_value] }])
      .order(:position).order('features.name', 'feature_values.name')
  end

  def ordered_product
    @ordered_product = OrderedProduct.find(params[:id])
  end
end
