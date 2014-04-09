class LessonPlan

  this.init = ->
    initTinyMce()
    $('#dropdown').change filter
    $(".filterable").filterTable()

  initTinyMce = ->
    tinymce.init
      menubar: 'edit view format table'
      selector: 'textarea'
      height: '300px'
      autoresize: true
      plugins: 'fullscreen table'
      tools: 'inserttable'

  filter = ->
      course = $(this).find('select :selected')
      if course.text() == 'All Courses'
        Turbolinks.visit '/lesson_plans'
      else
        Turbolinks.visit '/lesson_plans?course=' + course.val()

$(document).ready LessonPlan.init
$(document).on 'page:load', LessonPlan.init
