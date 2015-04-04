class ChangeLocationColumnToDepartmentInEventsTable < ActiveRecord::Migration
  def change
    rename_column(:events, :location, :department)
  end
end
