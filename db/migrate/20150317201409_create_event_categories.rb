class CreateEventCategories < ActiveRecord::Migration
  def change
    create_table :event_categories do |t|
      t.string :category_name

      t.timestamps
    end
  end
end
