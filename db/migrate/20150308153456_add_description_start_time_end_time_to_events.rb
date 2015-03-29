class AddDescriptionStartTimeEndTimeToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :description, :text
  	add_column :events, :start_time, :datetime
  	add_column :events, :end_time, :datetime

  end
end
