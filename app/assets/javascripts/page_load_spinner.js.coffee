class PageLoadSpinner
  opts =
    length: 6,
    widht: 5,
    color: '#999999',
    radius: 20

  this.start = () ->
    spinner = new Spinner(opts).spin()
    $("#page-load-spinner").hide()
    $('#page-load-spinner').append spinner.el
    setTimeout (-> $("#page-load-spinner").show()), 1000

  this.stop = () ->
    spinner = new Spinner(opts).stop()

$(document).on 'page:fetch', PageLoadSpinner.start
$(document).on 'page:load',  PageLoadSpinner.stop

