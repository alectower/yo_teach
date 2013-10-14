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
      course = $(this).find('select :selected')
      if course.text() == 'All Courses'
        document.location.href = '/lesson_plans'
      else
        document.location.href = '/lesson_plans?course=' + course.val()

$(document).ready ->
  LessonPlan.filter()
  LessonPlan.initTinyMce()
$(document).on 'page:load', ->
  LessonPlan.filter()
  LessonPlan.initTinyMce()
