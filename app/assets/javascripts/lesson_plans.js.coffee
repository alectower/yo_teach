class LessonPlan

  this.filter = ->
    $('.course-list').change ->
      course = $(this).find('select :selected').text()
      filterCourses(course)

  filterCourses = (courseName) ->
    $('.lesson-plans table td').parent().show()
    unless courseName == 'All Courses'
      $('.lesson-plans table td:nth-child(3)').filter ->
        return $(this).text().indexOf(courseName) == -1
      .parent().hide()

$(document).ready LessonPlan.filter
$(document).on 'page:load', LessonPlan.filter
