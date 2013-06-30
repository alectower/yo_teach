# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Courses
	
	me = null

	constructor: (el) ->
		me = this
		method = $(el).data('method')
		$(el).off('click').click(me[method])

	makeActive: () ->
		me.removeControls()
		$(this).addClass('active')
		$('#courses-body > ul > li').not(this).removeClass('active')
		$('#course-control')
			.append("<a id='edit-course' data-no-turbolink data-remote='true'\
				data-method='edit' href='/courses/" + $(this).data('id') + "' >\
				<i class='icon-pencil' ></i> Edit</a>")
			.append("<a id='delete-course' data-no-turbolink data-remote='true'\
				data-method='delete' href='/courses/" + $(this).data('id') + "'>\
				<i class='icon-trash' ></i> Delete</a>")
		$('#edit-course').off('click').click () ->
			$(this).remove()
			$('#delete-course').remove()
		$('#delete-course').off('click').click () ->
			$(this).remove()
			$('#edit-course').remove()

	removeControls: () ->
		$('#delete-course').remove()
		$('#edit-course').remove()

Handlers.register 'Courses', Courses