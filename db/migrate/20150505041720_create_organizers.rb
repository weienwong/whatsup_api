class CreateOrganizers < ActiveRecord::Migration
  def change
    create_table :organizers do |t|
      t.string :org_name
      t.string :org_website
      t.timestamps
    end
  end
end
