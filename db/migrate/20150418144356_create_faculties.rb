class CreateFaculties < ActiveRecord::Migration
  def change
    create_table :faculties do |t|
      t.string :faculty
      t.string :faculty_short

      t.timestamps
    end
  end
end
