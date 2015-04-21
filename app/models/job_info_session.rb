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
  
  # returns a list of all job info session periods
  # and the number of events happening at that time

  def self.job_info_session_time_period_count
    upcoming_sessions = JobInfoSession.where("start_time >= ?", DateTime.now)

    today_count = upcoming_sessions.where("start_time <= ?", DateTime.now.end_of_day).length()
    this_week_count = upcoming_sessions.where("start_time <= ?", DateTime.now.end_of_week).length()
    this_month_count = upcoming_sessions.where("start_time <= ?", DateTime.now.end_of_month).length()
    later_count = JobInfoSession.where("start_time >= ?", DateTime.now.end_of_month).where("start_time <= ?", DateTime.now.end_of_month  + 1.month).length()

    return [{:value => 'today', :label => 'Today', :count => today_count}, {:value => 'week', :label => 'This Week', :count => this_week_count}, {:value => 'month', :label => 'This Month', :count => this_month_count}, {:value => 'later', :label => 'Later', :count => later_count}]
    
  end





end
