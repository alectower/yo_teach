class @Handlers
  @handlers = {}

  @register: (handler, registered_class) ->
    throw "No constructor on " + handler unless registered_class.constructor
    @handlers[handler] = registered_class

  @instantiate: (handlers, element) ->
    handlers = handlers.replace(/\s/g, '').split(',')
    element.handlers = []
    $.each handlers, (index, handler) =>
      if @handlers[handler]
        instance = new @handlers[handler](element)
        element.handlers.push instance
      else
        throw "Unknown handler " + handler

  @destroy: (instances) ->
    $.each instances, (index, instance) ->
      instance.destroy() if instance.destroy

  @unregister_all: ->
    @handlers = {}

$(document).on 'handlers:pageChanged', ->
  $('[data-handler]').each ->
    Handlers.instantiate $(this).attr('data-handler'), this

$(document).on 'handlers:pageUpdated', (event, scope) ->
  $(scope).find('[data-handler]').each ->
    Handlers.instantiate $(this).attr('data-handler'), this

$(document).on 'handlers:pageUpdating', (event, scope) ->
  $(scope).find('[data-handler]').each ->
    Handlers.destroy @handlers if @handlers
    delete @handlers if @handlers

if typeof(Turbolinks) != undefined
  $(document).on 'page:fetch', ->
    $(document).trigger 'handlers:pageUpdating', 'body'

  $(document).on 'page:change', ->
    $(document).trigger 'handlers:pageUpdated', 'body'

  $ ->
    $(document).trigger 'handlers:pageChanged'
