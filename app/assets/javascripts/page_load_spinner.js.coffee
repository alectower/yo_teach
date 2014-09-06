opts =
  length: 6,
  widht: 5,
  color: '#999999',
  radius: 20

startSpinner = () ->
  spinner = new Spinner(opts).spin()
  spinIt = () ->
    $('#page-load-spinner').append spinner.el
  spinIt()
  $("#page-load-spinner").hide()
  setTimeout (-> $("#page-load-spinner").show()), 2000

stopSpinner = () ->
  spinner = new Spinner(opts).stop()

$(document).on 'page:fetch', startSpinner
$(document).on 'page:load', stopSpinner

