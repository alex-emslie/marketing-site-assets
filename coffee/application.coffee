class Megapane
  constructor: ->
    @mode = ""
    @is_open = false
    @target = ""
    @trigger = ""
    @offset = 0
    @template = $("<div class='megapane' id='megapane'><div class='arrow'></div><a href='#' class='close-btn'><svg><use xmlns:xlink='http://www.w3.org/1999/xlink' xlink:href='#shape-video_close'></use></svg></a><div class='content'></div></div>")
    @bindEvents()

  get_target: ->
    @target = switch matchMedia('only screen and (min-width: 1024px)').matches
      when true then $(@trigger).parents('.row')
      when false then $(@trigger).parents('.customer-card')

  get_contents: ->
    $($(@trigger).attr('href')).html()

  toggle_card_active: ->
    $('.has-desc').removeClass('active')
    $(@trigger).parents('.customer-card').addClass('active')

  close: (clear_trigger  = true) ->
    e = $.Event('close.megapane')
    $(@trigger).trigger(e)
    $('#megapane').animate({ height: 'toggle' }, 200, ->
      $('#megapane').remove()
    )
    $('.has-desc').removeClass('active')
    @trigger = "" if clear_trigger
    @is_open = false

  open: ->
    e = $.Event('open.megapane')
    $(@trigger).trigger(e)
    @get_target()
    @set_arrow_offset()
    @target.after(@template.find('.content').html(@get_contents()).end())
    $('#megapane').animate({height: 'toggle'}, 200) if !@is_open
    @toggle_card_active()
    @is_open = true

  set_arrow_offset: ->
    @offset = ($(@trigger).offset().left - $(@trigger).parents('.row').offset().left)+ $(@trigger).outerWidth()/2 - 15
    @template.find('.arrow').css('left', @offset)

  bindEvents: ->
    $('.js-megapane-toggle').on 'click', (e) =>
      e.preventDefault()
      if e.target == @trigger
        @close()
      else
        @trigger = e.target
        @open()

    $('.js-megapane-toggle').on 'open.megapane', (e) ->
      $('.js-dropup').tooltip('hide')

    $(document).on 'click', '.megapane .close-btn', (e) =>
      e.preventDefault()
      @close()

    # $(window).on 'resize', (e) =>
    #   console.log( @is_open )
    #   if @is_open
    #     if matchMedia('only screen and (min-width: 1024px)').matches && @mode != "desktop"
    #       console.log("desktop")
    #       @close(false)
    #       @open()
    #       @mode = "desktop"
    #     else if matchMedia('only screen and (max-width: 1024px)').matches && @mode != "mobile"
    #       console.log("mobile")
    #       @close(false)
    #       @open()
    #       @mode = "mobile"



$ ->

  ad = ad || {}
  subdomain = window.location.host.split('.')[0]
  switch subdomain
    when 'www'
      # production
      svgs_url = 'http://info.appdirect.com/assets_new/svg/svgs.svg'
    when 'ad-dc'
      # github / project-runway
      svgs_url = './assets_new/svg/svgs.svg'
    else
      # dev, staging, local, info.appdirect
      svgs_url = '/assets_new/svg/svgs.svg'
  $.get svgs_url, (data) ->
    div = document.createElement("div")
    div.className = "svgstore"
    div.innerHTML = new XMLSerializer().serializeToString(data.documentElement)
    document.body.insertBefore(div, document.body.childNodes[0])
    $('body').removeClass('no-svgs').addClass('svgs-loaded')

  ad.heroCenter = ->
    if matchMedia('only screen and (min-width: 750px)').matches && $('.hero-copy').length > 0
      $('.hero-copy').css "margin-top" : ($('.hero').height() - $('.hero-copy').height() - 65) / 2
    if matchMedia('only screen and (max-width: 750px)').matches && $('.hero-copy').length > 0
      $('.hero-copy').css "margin-top" : "20px"
  ad.heroCenter()

  scrollConfig =
    complete: (el) ->
      if $(el).is('.half-width.graph')
        $('g#btn-1').tooltip('show')
        $('g#btn-1').attr("class", "step-1 active")

  ad.sr = new scrollReveal(scrollConfig) unless $('html').hasClass('ie8')

  $('.stacked-list-item').hover(
    ->
      $img = $(this).find('.list-image')
      $img.attr('src', $img.attr('src').replace("_light.svg", "_dark.svg"))
    , ->
      $img = $(this).find('.list-image')
      $img.attr('src', $img.attr('src').replace("_dark.svg", "_light.svg"))
  )
    
  $('.js-filter-show').on "click", (e) ->
    e.preventDefault()
    $(this).siblings('.filter-container').toggleClass("open")

  if $('.js-ee-filter').length > 0
    path = window.location.pathname
    #console.log path
    p_arr = path.replace(/^\/[a-z]*\/?/g, "").split("/").filter(Boolean)
    
    if p_arr.length > 1
      p_obj = {}
      for segment, i in p_arr by 2
        p_obj[segment] = p_arr[i + 1]
      for key, value of p_obj
        $('.js-ee-filter[data-segment-key=' + key + ']').val(value)

  $('.js-ee-filter').on "change", (e) ->
    new_value = $(this).val()
    #console.log new_value
    changing_key = $(this).attr('data-segment-key')
    server = window.location.origin
    path = window.location.pathname
    p_arr = path.replace(/^\/[a-z]*\/?/g, "").split("/").filter(Boolean)
    #console.log p_arr
    p_obj = {}
    for segment, i in p_arr by 2
      p_obj[segment] = p_arr[i + 1]

    if new_value == "clear"
      delete p_obj[changing_key]
    else
      p_obj[changing_key] = new_value

    rv = []
    for key, value of p_obj
      rv.push(key, value)
      #console.log rv

    window.location = server + "/resources/" + rv.join("/")
    

    

  unless $('html').is('[class^="ie"]')
    $('#graph g[id^="btn"]').hover(
      ->
        target = $(this).attr('class')
        # change the fill of all path/polygon elements that are not children of the step
        $('g[class^="step"]').not(".#{target}").find("path, polygon").css('fill', '#e6e7e7')
        $('#top-icons g[class^="step"]').not(this).find("path, polygon").css('fill', 'transparent')
        $(".#{target}").find("path, polygon").css('fill', '#133a4e')
        # $(".#{target}").find(".ring").css("-webkit-transform", "rotate(180deg)")
        return true
      , ->
        target = $(this).attr('class')
        $('g[class^="step"]').find("path, polygon").css('fill', '')
        # $(".#{target}").find(".ring").css("-webkit-transform", "rotate(360deg)")
    )

  # $('.ga_push').on "click", ->
  #   text = $(this).attr("data-eventname")
  #   _gaq.push(['_trackEvent', text])

  _hsq = window._hsq = window._hsq || []
  $('*[data-hubsp-eventname]').on "click", (e) ->
    #e.preventDefault()
    eventname = $(this).attr("data-hubsp-eventname")
    _hsq.push(["trackEvent", { id: eventname }])


  ad.replaceGifs = ->
    if matchMedia('only screen and (min-width: 750px)').matches
      $('img.js-delay-gif').each (index) ->
        $(this).attr('src', $(this).attr('src').replace(/\.jpg|\.png/, ".gif"))

  ad.removeVideo = ->
    if $('#headerVid').length > 0
      $('#headerVid').remove()

  ad.replaceVideo = ->
    if $('#headerVid').length == 0 && $('.videoContainer').length > 0
      $('.videoContainer').append($('<video class="video" id="headerVid" loop="true" muted="true" poster="http://www.appdirect.com/assets_new/imgs/video_placeholder.jpg" autoplay="true" ><!--autobuffer="true"-->
        <source src="https://embed-ssl.wistia.com/deliveries/47d64fae619ed832386cbd85f40504fb23a3141a/file.mp4" type="video/mp4" media="all and (min-width: 600px)">
      </video>'))
      $('.video').animate { opacity: 1}, 'slow'

  ad.runBreakpoints = ->
    if matchMedia('only screen and (min-width: 750px)').matches
      ad.replaceVideo()
      ad.replaceGifs()
    if matchMedia('only screen and (max-width: 750px)').matches
      ad.removeVideo()

  ad.runBreakpoints()

  $(window).resize ->
    ad.runBreakpoints()
    ad.heroCenter()

  $('.js-replace-select').chosen(
    disable_search_threshold: 20
    width: 'auto'
  )

  $('a.learn-more').click ->
    heroOffset = $('.hero .videoContainer').height() - 70
    $('body').stop().animate { scrollTop: heroOffset }, 650

  $('.menu-burger, .menu-items').on 'click', ->
    $('.menu-bg, .menu-items, .menu-burger, .mobile-nav .logo').toggleClass 'fs'
    $('body').toggleClass('overflow')
    if $('.menu-burger').text() == '☰' then $('.menu-burger').text('✕') else $('.menu-burger').text('☰')

  $('.tooltip-active').tooltip()

  ad.megapane = new Megapane

  # dropup menus (customers page)
  $('.js-dropup').tooltip({
    html: true
    title: ->
      $(this).siblings('.dropup').html()
    trigger: 'manual'
    template: '<div class="tooltip shadow" role="tooltip"><div class="tooltip-inner auto"></div></div>'
  }).on 'click', (e) ->
      e.preventDefault()
      $(this).parents('.customer-card').addClass('active')
      $('.js-dropup').not($(this)).tooltip('hide')
      ad.megapane.close() if ad.megapane.is_open
      $(this).tooltip('toggle')
  .on 'hide.bs.tooltip', (e) ->
    $(this).parents('.customer-card').removeClass('active')

  # tooltips in homepage graph
  $('g[id^="btn"]').hover(
   ->
     $('g#btn-1').attr("class", "step-1") if $('g#btn-1').attr("class", "step-1 active")
     $('g[id^="btn"]').tooltip('hide')
     $(this).tooltip('show')
   , ->
     $(this).tooltip('hide')
  ).tooltip({
    html: true
    container: 'body'
    template: '<div class="tooltip blue active" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'
  })

  itemfilter = {}
  filterItems = (itemfilter) ->
    # filter through .filter-elements
    $.each(itemfilter, (key, value) ->
      $(".filter-element").not("[data-#{key}~='#{value}']").hide()
    )
    # hide unused sections
    $('.customer-cards').each ->
      if $(this).find('.filter-element:visible').length == 0
        $(this).hide()
    # preserve grid layout
    if matchMedia('only screen and (min-width: 750px)').matches
      $('.is-featured:visible').each (i) ->
        if ((i+1) % 3 == 0)
          $(this).css('padding-right', '0')
        else
          $(this).css('padding-right', '18px')
      $('.filter-element:not(.is-featured):visible').each (i) ->
        if ((i+1) % 4 == 0)
          $(this).css('padding-right', '0')
        else
          $(this).css('padding-right', '18px')
    # add no results message
    if $('.filter-element:visible').length == 0
      #console.log "nothing to show"
      $('.filter-group').after($("<h1 class='no-results' style='color: white;'>We're sorry, but there are no results for your selections. Please <a href='/customers' class='js-filter-reset'>reset</a> or change your filter settings.</h1>"))

  $('.filter-select').on 'change', (e) ->
    e.preventDefault()
    $('.no-results').remove()
    filter = $(this).attr('data-filter')
    value = $(this).val()
    if $(this).find(":selected").hasClass('default') then delete itemfilter[filter] else itemfilter[filter] = value
    #console.log itemfilter
    $("[data-#{filter}], .customer-cards").show()
    $('.is-featured:visible').removeAttr("style")
    filterItems(itemfilter)

  $(document).on 'click', '.js-filter-reset', (e) ->
    e.preventDefault()
    itemfilter = {}
    $('.no-results').remove()
    $('.filter-element, .customer-cards').show()
    $('.js-replace-select').find('option.default').prop('selected', true).end().trigger('chosen:updated')
