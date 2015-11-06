class AddDefaultToBonusPointsOnUsers < ActiveRecord::Migration
  def change
    change_column :users, :bonus_points, :decimal, precision: 15, scale: 2, default: 0
  end
end
