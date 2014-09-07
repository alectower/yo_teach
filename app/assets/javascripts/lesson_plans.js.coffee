class LessonPlan

  this.init = ->
    initTinyMce()
    $('#dropdown').change filter
    $(".filterable").filterTable()
    setTab()
    standardsSearchInit()

  initTinyMce = ->
    tinymce.init
      menubar: 'edit view format table'
      selector: 'textarea'
      height: '230px'
      autoresize: true
      plugins: 'fullscreen table'
      tools: 'inserttable'

  filter = ->
    course = $(this).find('select :selected')
    if course.text() == 'All Courses'
      Turbolinks.visit '/lesson_plans'
    else
      Turbolinks.visit '/lesson_plans?course=' + course.val()

  setTab = ->
    if /lesson_plans/.test(document.URL)
      tab = document.URL.split('#')[1]
      link = $('a[href="#' + tab + '"') if tab
      if tab != 'undefined' && link && link.length != 0
        link.tab('show')
      $('a[data-toggle="tab"]').click ->
        tab = this.name
        new_url = document.URL.replace /[?#].+/, "##{tab}"
        window.history.pushState({path: new_url}, 'YoTeach', new_url)

  standardsSearchInit = ->
    $('#standards-search').click (e) ->
      e.preventDefault()
      url = document.URL
      url = url.replace /[?&]search\=.+[&#]/, (match) ->
        if /#$/.test match then '#' else '&'
      search = $('#search').val()
      url_pieces = url.split('#')

      search_string = if /\?+/.test(url_pieces) then '&' else '?'
      search_string += "search=#{encodeURIComponent(search)}"

      new_url = if url_pieces[1]
        "#{url_pieces[0]}#{search_string}##{url_pieces[1]}"
      else
        "#{url}#{search_string}#standards-tab"

      Turbolinks.visit new_url

$(document).ready LessonPlan.init
$(document).on 'page:load', LessonPlan.init
