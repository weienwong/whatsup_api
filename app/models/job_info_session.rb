class JobInfoSession < ActiveRecord::Base

  def self.show_session_by_time(time)
    upcoming = JobInfoSession.where("start_time >= ?", DateTime.now)
    if time == 'today'
      result = upcoming.where("start_time <= ?", DateTime.now.end_of_day)

    elsif time == 'week'
      result = upcoming.where("start_time <= ?", DateTime.now.end_of_week)

    elsif time == 'month'
      result = upcoming.where("start_time <= ?", DateTime.now.end_of_month)

    elsif time == 'later'
      result = JobInfoSession.where("start_time >= ?", DateTime.now.end_of_month).where("start_time <= ?", DateTime.now.end_of_month  + 1.month)
    end

    return result.select(:id, :employer, :start_time, :end_time, :location, :website, :education_level, :student_type, :faculties).order(:start_time)
  end
  
  # faculty can be one of the following:
  # MATH, ARTS, ENG, AHS, SCI, ENV
  def self.show_session_by_faculty(faculty)
    return JobInfoSession.where("faculties like ?", "%" + faculty + "%").select(:employer, :start_time, :end_time, :location, :website, :education_level, :student_type, :faculties)
  end
  
  # student type can be one of the following:
  # Co-op or Graduating
  def self.show_session_by_student_type(student_type)
    return JobInfoSession.where("student_type like ?", "%" + student_type + "%").select(:employer, :start_time, :end_time, :location, :website, :education_level, :student_type, :faculties)
  end





end
