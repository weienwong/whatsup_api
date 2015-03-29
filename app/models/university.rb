class University < ActiveRecord::Base
  has_one :event
  # checks if university id already exists

  def self.valid_university_id(university_id)
    
    if (university_id.nil?)
      return false
    end

    if self.where("id = " + university_id).empty?
      return false
    else
      return true
    end
  end

end
