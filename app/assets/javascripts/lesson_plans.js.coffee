class LessonPlan

  this.initTinyMce = ->
    tinymce.init
      menubar: 'edit view format table'
      selector: 'textarea'
      height: '300px'
      autoresize: true
      plugins: 'fullscreen table'
      tools: 'inserttable'

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
      $('th a').attr('href', ->
        this + '&course=' + courseName)

$(document).ready ->
  LessonPlan.filter()
  LessonPlan.initTinyMce()
$(document).on 'page:load', ->
  LessonPlan.filter()
  LessonPlan.initTinyMce()
