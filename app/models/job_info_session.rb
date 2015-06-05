class JobInfoSession < ActiveRecord::Base

  def self.show_session_by_time(time)
    upcoming = JobInfoSession.where("end_time >= ?", DateTime.now)
    if time == 'today'
      result = upcoming.where("end_time <= ?", DateTime.now.end_of_day)

    elsif time == 'week'
      result = upcoming.where("end_time <= ?", DateTime.now.end_of_week)
    
    elsif time == 'this_month'
      result = upcoming.where("end_time <= ?", DateTime.now.end_of_month)

    elsif time == 'next_month'
      result = JobInfoSession.where("end_time >= ?", DateTime.now.end_of_month).where("end_time <= ?", DateTime.now.end_of_month  + 1.month)
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

  def create_job_info_session_invite(email_address=nil)

    cal = Icalendar::Calendar.new

    cal_event = Icalendar::Event.new

    cal_event.dtstart = Icalendar::Values::DateTime.new(self.start_time.localtime)
    cal_event.dtend = Icalendar::Values::DateTime.new(self.end_time.localtime)
    cal_event.summary = self.employer + " Info Session"
    cal_event.location = self.location
    
    cal.add_event(cal_event)
    cal.publish
    
    File.open("./ics/" + self.id.to_s + ".ics", "w+") do |f|
      f.write(cal.to_ical)
    end

    begin
      RestClient.post "https://api:key-eafc5e70e6bcb71af6ba5d95c8132cf3"\
        "@api.mailgun.net/v3/sandbox3af273bc6e66458f9b9a4015b7d3a28e.mailgun.org/messages",
        :from => "WatsUp <mailgun@sandbox3af273bc6e66458f9b9a4015b7d3a28e.mailgun.org>",
        :to => email_address,
        :subject => self.employer + " Info Session",
        :text => "Event Name: " + self.employer + " Info Session" + "\n\n" +
                  "Start Time: " + self.start_time.localtime.to_formatted_s(:long_ordinal) + "\n\n" +
                  "End Time: " + self.end_time.localtime.to_formatted_s(:long_ordinal) + "\n\n" +
                  "Location: " + self.location + "\n\n" +
                  "Website: " + self.website,
        :attachment => File.open("./ics/" + self.id.to_s + ".ics", "r")  

    rescue => e

    end

  
  end



end
