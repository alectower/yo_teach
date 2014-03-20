class Calendar

  this.init = ->
    addLessonPlan()
    addDailySchedule()

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
    $('td.minute-col').html('').attr('rowspan', '0')
    $(lessons).each (index, lesson) ->
      startTime = new Date(lesson.start)
      startMinute = (startTime.getUTCHours() * 60) +
        startTime.getMinutes()
      startRow = $('tr.minute-' + startMinute)
      dayNumber = startTime.getDay()
      day = startRow.find('td.day-' + dayNumber)
      endTime = new Date(lesson.end)
      endMinute = (endTime.getUTCHours() * 60) +
        endTime.getMinutes()
      classLength = endMinute - startMinute
      day.attr('rowspan', classLength)
      console.log(day.css('height'))
      nextRows = day.parent().siblings().
        slice(startMinute, startMinute + classLength - 1)
      nextRows.find('td.day-' + dayNumber).remove()
      day.append('<div id="day-lesson-' + lesson.id +
        '" class="weekly-lesson status-' + lesson.status +
        '" style="height:' + day.css('height') +
        ';">' + lesson.title + '</div>')
    setPopovers()

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
