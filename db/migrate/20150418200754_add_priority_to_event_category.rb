class AddPriorityToEventCategory < ActiveRecord::Migration
  def change
    add_column :event_categories, :priority, :integer
  end
end
