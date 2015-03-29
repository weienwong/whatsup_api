class AddUniversityToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :university, index: true
  end
end
