class RemoveSiteIdFromUniversityEvents < ActiveRecord::Migration
  def change
    remove_column :university_events, :site_id
  end
end
