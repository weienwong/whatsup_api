class CreateUniversityEvents < ActiveRecord::Migration
  def change
    create_table :university_events do |t|

      t.string :name
      t.text :text

      t.timestamps
    end
  end
end
