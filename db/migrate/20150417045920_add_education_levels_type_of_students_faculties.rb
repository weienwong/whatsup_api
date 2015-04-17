class AddEducationLevelsTypeOfStudentsFaculties < ActiveRecord::Migration
  def change
    add_column :job_info_sessions, :education_level, :string
    add_column :job_info_sessions, :student_type, :string
    add_column :job_info_sessions, :faculties, :string
  end
end
