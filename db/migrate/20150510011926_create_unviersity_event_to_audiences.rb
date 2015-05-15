class CreateUnviersityEventToAudiences < ActiveRecord::Migration
  def change
    create_table :unviersity_event_to_audiences do |t|
      t.belongs_to :university_event, index: true
      t.belongs_to :audience, index: true
      t.timestamps
    end
  end
end
