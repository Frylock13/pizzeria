class OrderedPizzasController < ApplicationController
  def increase
    redirect_to root_path, change: :cart
  end

  def decrease
    redirect_to root_path, change: :cart
  end
end
