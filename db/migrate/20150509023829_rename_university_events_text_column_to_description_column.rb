class RenameUniversityEventsTextColumnToDescriptionColumn < ActiveRecord::Migration
  def change
    rename_column :university_events, :text, :description
  end
end
