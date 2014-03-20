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
    $(lessons).each (index, lesson) ->
      startTime = new Date(lesson.start)
      startMinute = (startTime.getUTCHours() * 60) +
        startTime.getMinutes()
      endTime = new Date(lesson.end)
      endMinute = (endTime.getUTCHours() * 60) +
        endTime.getMinutes()
      classLength = endMinute - startMinute
      dayNumber = startTime.getDay()
      day = $('#day-' + dayNumber)
      day.append('<div id="day-lesson-' + lesson.id +
        '" class="weekly-lesson status-' + lesson.status +
        '" style="top:' + (startMinute * 2) +
        'px; height:' + (classLength * 2) +
        'px;">' + lesson.title + '</div>')
    updateWidths()
    setPopovers()

  updateWidths = ->
    for day in [1..7]
      do (day) ->
        dayColumn = $('#day-' + day)
        overlaps = findOverlaps(dayColumn.children())
        if overlaps > 0
          dayWidth = dayColumn.css('width')
          dayColumn.children().css('width', (dayWidth.replace('px', '') // (overlaps + 1)) - 2)

  findOverlaps = (lessons) ->
    overlaps = 0
    lessons.each (index, lesson) ->
      nextLesson = $(lessons[index + 1])
      lesson = $(lesson)
      if nextLesson
        currentStart = lesson.css('top')
        nextStart = nextLesson.css('top')
        currentEnd = lesson.css('top') +
          lesson.css('height')
        if nextStart >= currentStart &&
          nextStart <= currentEnd
            overlaps += 1
    overlaps

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
