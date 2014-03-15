class Calendar

  this.init = ->
    addLessonPlan()
    addDailySchedule()
    setPopovers()

  addLessonPlan = ->
    $('.day').hover(showLink, hideLink)

  showLink = ->
    $(this).find('.add-lesson-plan').show()

  hideLink = ->
    $('.add-lesson-plan').not(this).hide()

  addDailySchedule = ->
    $('.minute-row').each (index, row) ->
      hour = $(row)
      if index % 60 == 0
        cols = hour.find('td:not(:first-child)')
        cols.addClass('hour-border')
    lessons = $('.lesson-data').map (index, lesson) ->
      $(lesson).data('lesson')
    Calendar.addLessons(lessons)

  this.addLessons = (lessons) ->
    $('td.minute-col').html('')

    $(lessons).each (index, lesson) ->
      startTime = new Date(lesson.start)

      startMinute = (startTime.getUTCHours() * 60) +
        startTime.getMinutes()

      startRow = $('tr.minute-' + startMinute)

      day = startRow.find('td.day-' + startTime.getDay())

      endTime = new Date(lesson.end)

      endMinute = (endTime.getUTCHours() * 60) +
        endTime.getMinutes()

      classLength = endMinute - startMinute

      if day.attr('rowspan') == undefined ||
        classLength > day.attr('rowspan')
          day.attr('rowspan', classLength)

      day.append('<div id="day-lesson-' + lesson.id +
        '" class="weekly-lesson status-' + lesson.status +
        '">' + lesson.title + '</div>')

  setPopovers = ->
    $('.weekly-lesson').each (index, lesson) ->
      lessonId = lesson.id.replace /day-/, ''
      $('#' + lesson.id).popover({
        html: true,
        content: $('#' + lessonId).html(),
        container: '#popover'
      })

window.Calendar = Calendar
$(document).ready Calendar.init
$(document).on 'page:load', Calendar.init
