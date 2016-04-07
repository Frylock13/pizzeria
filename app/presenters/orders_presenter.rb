class OrdersPresenter < ApplicationPresenter
  presents :orders

  def total_count
    orders.count
  end

  def total_sum
    sum = 0
    orders.find_each { |order| sum += order.price }
    sum
  end
end
