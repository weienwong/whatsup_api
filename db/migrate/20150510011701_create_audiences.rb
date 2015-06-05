class CreateAudiences < ActiveRecord::Migration
  def change
    create_table :audiences do |t|
      t.string :audience_group
      t.timestamps
    end
  end
end
