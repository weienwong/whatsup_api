class AddSiteIdToUniversityEventTable < ActiveRecord::Migration
  def change
    add_column :university_events, :site_id, :integer
  end
end
