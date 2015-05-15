class AddWebsiteToUniversityEvent < ActiveRecord::Migration
  def change
    add_column :university_events, :website, :string
  end
end
