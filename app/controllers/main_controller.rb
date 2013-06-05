class MainController < ApplicationController

def main
    @services = {
      courses: Course.all,
      calendar: CalendarService.new.get_calendar_courses,
      notes: Note.all
    }
  end
 
end
