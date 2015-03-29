class CreateEventTimes < ActiveRecord::Migration
  def change
    create_table :event_times do |t|
      t.belongs_to :event, index: true 
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps
    end
  end
end
