class CreateUniversityEventCategories < ActiveRecord::Migration
  def change
    create_table :university_event_categories do |t|

      t.belongs_to :university_event, index: true
      t.belongs_to :event_category, index: true

      t.timestamps
    end
  end
end
