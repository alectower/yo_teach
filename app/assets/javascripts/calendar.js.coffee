
class Calendar

	this.addLessonPlan = ->
		$('.day').hover(showLink, hideLink)
	
	showLink = ->
		$(this).find('.add-lesson-plan').show()

	hideLink = ->
		$('.add-lesson-plan').not(this).hide()

$(document).ready Calendar.addLessonPlan
$(document).on 'page:load', Calendar.addLessonPlan
