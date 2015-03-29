class AddWebsiteToEvent < ActiveRecord::Migration
  def change
    add_column :events, :website, :text
  end
end
