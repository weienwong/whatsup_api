class AddEventIdToEventToEventCategoriesTable < ActiveRecord::Migration
  def change
   add_reference :events_to_event_categories, :event, index: true
   add_reference :events_to_event_categories, :event_category, index: true
  end
end
