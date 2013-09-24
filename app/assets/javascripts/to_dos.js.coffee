class ToDo

	this.remove = ->
		$('.to-do').change ->
			removeToDo(this.id)
			
	removeToDo = (id) ->
		$.ajax
			type: 'DELETE'
			url: '/to_dos/' + id
			success: ->
				removeToDoFromPage(id)

	removeToDoFromPage = (id) ->
		setTimeout $('#' + id)
			.parent()
			.parent()
			.remove(), 5000

$(document).ready ToDo.remove
$(document).on 'page:load', ToDo.remove
