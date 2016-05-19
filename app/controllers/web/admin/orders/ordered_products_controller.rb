class Web::Admin::Orders::OrderedProductsController < Web::Admin::Orders::ApplicationController
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

  def ordered_product
    @ordered_product = OrderedProduct.find(params[:id])
  end
end
