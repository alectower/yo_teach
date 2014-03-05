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
    addLessons()

  addLessons = ->
    lessons = $('#week-lessons').data('lessons')
    $('td.minute-col').html('')
    $(lessons).each (index, lesson) ->
      startTime = new Date(lesson.start)
      startMinute = (startTime.getHours() * 60) + startTime.getMinutes()
      startRow = $('tr.minute-' + startMinute)
      day = startRow.find('td.day-' + startTime.getDay())
      endTime = new Date(lesson.end)
      endMinute = (endTime.getHours() * 60) + endTime.getMinutes()
      classLength = endMinute - startMinute
      day.attr('rowspan', classLength)
      day.append('<div class="weekly-lesson status-' +
        lesson.status + '">' + lesson.title + '</div>')


$(document).ready Calendar.init
$(document).on 'page:load', Calendar.init
