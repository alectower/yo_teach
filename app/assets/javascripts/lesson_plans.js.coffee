class LessonPlan

  this.init = ->
    initTinyMce()
    filter()
    filterStandards()

  initTinyMce = ->
    tinymce.init
      menubar: 'edit view format table'
      selector: 'textarea'
      height: '300px'
      autoresize: true
      plugins: 'fullscreen table'
      tools: 'inserttable'

  filter = ->
    $('#dropdown').change ->
      course = $(this).find('select :selected')
      if course.text() == 'All Courses'
        Turbolinks.visit '/lesson_plans'
      else
        Turbolinks.visit '/lesson_plans?course=' + course.val()

  filterStandards = ->
    $(".filterable").filterTable()

$(document).ready ->
  LessonPlan.init()
$(document).on 'page:load', ->
  LessonPlan.init()
