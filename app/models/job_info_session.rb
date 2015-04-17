class JobInfoSession < ActiveRecord::Base

  def self.show_session_by_time(time)
    upcoming = JobInfoSession.where("start_time >= ?", DateTime.now)
    if time == 'today'
      today_sessions = upcoming.where("start_time <= ?", DateTime.now.end_of_day)
      return today_sessions.select(:employer, :start_time, :end_time, :location, :website, :education_level, :student_type, :faculties)

    elsif time == 'week'
      this_week_sessions = upcoming.where("start_time <= ?", DateTime.now.end_of_week)
      return this_week_sessions.select(:employer, :start_time, :end_time, :location, :website, :education_level, :student_type, :faculties)

    elsif time == 'month'
      this_month_sessions = upcoming.where("start_time <= ?", DateTime.now.end_of_month)
      return this_month_sessions.select(:employer, :start_time, :end_time, :location, :website, :education_level, :student_type, :faculties)

    elsif time == 'later'
      later_sessions = JobInfoSession.where("start_time >= ?", DateTime.now.end_of_month).where("start_time <= ?", DateTime.now.end_of_month  + 1.month)
      return later_sessions.select(:id, :employer, :start_time, :end_time, :location, :website, :education_level, :student_type, :faculties)
    end

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
