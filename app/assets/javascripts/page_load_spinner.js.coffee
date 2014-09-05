$(document).on 'page:fetch', ->
  target = $('#page-load-spinner')
  spinner = new Spinner().spin()
  target.append spinner.el
