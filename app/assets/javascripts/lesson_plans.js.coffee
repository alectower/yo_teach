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
    $('#dropdown').change ->
      course = $(this).find('select :selected')
      if course.text() == 'All Courses'
        Turbolinks.visit '/lesson_plans'
      else
        Turbolinks.visit '/lesson_plans?course=' + course.val()

$(document).ready ->
  LessonPlan.filter()
  LessonPlan.initTinyMce()
$(document).on 'page:load', ->
  LessonPlan.filter()
  LessonPlan.initTinyMce()
