class CreateUniverstiyEventOrganizers < ActiveRecord::Migration
  def change
    create_table :universtiy_event_organizers do |t|
      t.belongs_to :university_event, index: true
      t.belongs_to :organizer, index: true

      t.timestamps
    end
  end
end
