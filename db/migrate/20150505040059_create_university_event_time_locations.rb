class CreateUniversityEventTimeLocations < ActiveRecord::Migration
  def change
    create_table :university_event_time_locations do |t|

      t.belongs_to :university_event, index: true
      t.datetime :start_time
      t.datetime :end_time
      t.belongs_to :location, index: true
      t.timestamps
    end
  end
end
