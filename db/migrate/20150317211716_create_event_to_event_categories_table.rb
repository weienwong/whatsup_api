class CreateEventToEventCategoriesTable < ActiveRecord::Migration
  def change
    create_table :event_to_event_categories_tables do |t|
      t.belongs_to :event, index: true
      t.belongs_to :event_category, index: true
      t.timestamps null: false
    end
  end
end
