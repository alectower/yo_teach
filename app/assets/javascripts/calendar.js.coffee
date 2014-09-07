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
    lessons = $('.lesson-data').map (index, lesson) ->
      $(lesson).data('lesson')
    Calendar.addLessons(lessons)

  this.addLessons = (lessons) ->
    $('.weekly-lesson').remove()
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
        '" class="weekly-lesson status-' + (if lesson.complete then 'complete' else 'in-progress') +
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
        if overlaps.length > 0
          dayWidth = dayColumn.css('width').
            replace('px', '')
          $(overlaps).each (index, lesson) ->
            el = $('#' + lesson)
            width = (dayWidth // (overlaps.length)) - 2.5
            el.css('width', width)
            if index > 0
              el.css('left', width * index + 1)
            else
              el.css('left', 0)

  findOverlaps = (lessons, timeOverlaps = []) ->
    $(lessons).each (index, lesson) ->
      nextLesson = $(lessons[index + 1])
      lesson = $(lesson)
      if nextLesson.css('top') != undefined
        if isOverlap(lesson, nextLesson)
          timeOverlaps.push lesson.attr('id')
          timeOverlaps.push nextLesson.attr('id')
          nextOverlap = findOverlaps(
            lessons[(index + 1)..-1], timeOverlaps)
          timeOverlaps = nextOverlap.unique()
    timeOverlaps

  Array::unique = ->
    output = {}
    output[@[key]] = @[key] for key in [0...@length]
    value for key, value of output

  isOverlap = (lesson, nextLesson) ->
    currentStart = parseInt(
      lesson.css('top').replace('px', ''))
    nextStart = parseInt(
      nextLesson.css('top').replace('px', ''))
    currentEnd = currentStart +
      parseInt(lesson.css('height').replace('px', ''))
    nextEnd = nextStart +
      parseInt(nextLesson.css('height').
      replace('px', ''))
    if (nextStart >= currentStart &&
      nextStart < currentEnd) ||
      (nextEnd >= currentStart &&
      nextEnd <= currentEnd)
        true
    else
      false

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
