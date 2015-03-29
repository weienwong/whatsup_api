require 'test_helper'

class EventTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

#   test "create empty event" do
#     event = Event.new
#     assert event.save, "Cannot create empty event"
#   end

   test "create dummy event" do

     event = Event.new
     event.name = "Random test event"
     event.university_id = 1
     event.start_time = DateTime.now
     event.end_time = DateTime.now + 1
     event.location = "Anywhere"
     assert event.save, "Dummy event created!"

   end

   test "check dummy event" do

     event = Event.new
     event.name = "Random test event"
     event.university_id = 1
     event.start_time = DateTime.now
     event.end_time = DateTime.now + 1
     event.location = "Anywhere"
     assert event.save, "Dummy event created!"

   end

end
