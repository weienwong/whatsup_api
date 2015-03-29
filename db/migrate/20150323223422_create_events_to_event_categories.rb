class CreateEventsToEventCategories < ActiveRecord::Migration
  def change
    create_table :events_to_event_categories do |t|
      t.belongs_to :event, index: true
      t.belongs_to :event_category, index: true 
      t.timestamps
    end
  end
end
