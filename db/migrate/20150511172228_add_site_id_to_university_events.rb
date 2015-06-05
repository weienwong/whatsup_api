class AddSiteIdToUniversityEvents < ActiveRecord::Migration
  def change
    add_reference :university_events, :site, index:true, foreign_key:true
  end
end
