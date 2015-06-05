class CreateEventWebsites < ActiveRecord::Migration
  def change
    create_table :event_websites do |t|

      t.belongs_to :university_event, index: true
      t.string :url
      t.timestamps
    end
  end
end
