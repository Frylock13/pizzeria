class AddBonusPointsToUser < ActiveRecord::Migration
  def change
    add_column :users, :bonus_points, :decimal, precision: 15, scale: 2
  end
end
