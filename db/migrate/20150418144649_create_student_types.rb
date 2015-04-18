class CreateStudentTypes < ActiveRecord::Migration
  def change
    create_table :student_types do |t|
      t.string :student_type

      t.timestamps
    end
  end
end
