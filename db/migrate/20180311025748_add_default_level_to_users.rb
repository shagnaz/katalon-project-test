class AddDefaultLevelToUsers < ActiveRecord::Migration
  def change
  	change_column_default :users, :level , 0
  end
end
