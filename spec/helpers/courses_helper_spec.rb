require 'spec_helper'

describe "CoursesHelper" do
  include CoursesHelper

  it "creates form fields" do
    example = "<div class=\"control-group\">\
<label class=\"control-label\" for=\"course_end_time\">End time</label>\
<div class=\"controls\">\
<div class=\"input-prepend\">\
<span class=\"add-on\">\
<i class=\"icon-time\"></i>\
</span>\
<input id=\"course_end_time\" name=\"course[end_time]\" type=\"text\"></input>\
</div>\
</div>\
</div>"
  form_field(:end_time, 'icon-time').should eq example
  end  

end