$ ->
  ad = ad || {}
  svgs_url = if window.location.href.indexOf("local") is -1 then "http://info.appdirect.com/assets_new/svg/svgs.svg" else "/assets_new/svg/svgs.svg"
  $.get svgs_url, (data) ->
    div = document.createElement("div")
    div.className = "svgstore"
    div.innerHTML = new XMLSerializer().serializeToString(data.documentElement)
    document.body.insertBefore(div, document.body.childNodes[0])
    $('body').removeClass('no-svgs').addClass('svgs-loaded')

  ad.heroCenter = ->
    if matchMedia('only screen and (min-width: 750px)').matches
      $('.hero-copy').css "margin-top" : ($(window).height() - 188 - $('.hero-copy').outerHeight()) / 2
    if matchMedia('only screen and (max-width: 750px)').matches
      $('.hero-copy').css "margin-top" : "20px"
  ad.heroCenter()

  scrollConfig =
    complete: (el) ->
      if $(el).is('.half-width.graph')
        $('g#btn-1').tooltip('show')
        $('g#btn-1').attr("class", "step-1 active")

  ad.sr = new scrollReveal(scrollConfig) unless $('html').hasClass('ie8')

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

  $('.ga_push').on "click", ->
    text = $(this).attr("data-eventname")
    _gaq.push(['_trackEvent', text])

  # $('footer').parallax({imageSrc: '../build/imgs/footer.jpg'})
  $(window).stellar()

  ad.replaceGifs = ->
    if matchMedia('only screen and (min-width: 750px)').matches
      $('.js-delay-gif').each (index) ->
        $(this).attr('src', $(this).attr('src').replace(/\.jpg|\.png/, ".gif"))

  ad.removeVideo = ->
    if $('#headerVid').length > 0
      $('#headerVid').remove()

  ad.replaceVideo = ->
    if $('#headerVid').length == 0
      $('.videoContainer').append($('<video class="video" id="headerVid" loop="true" muted="true" poster="http://info.appdirect.com/assets_new/imgs/video_placeholder.jpg" autoplay="true" ><!--autobuffer="true"-->
        <source src="https://embed-ssl.wistia.com/deliveries/47d64fae619ed832386cbd85f40504fb23a3141a/file.mp4" type="video/mp4" media="all and (min-width: 600px)">
      </video>'))
      $('.video').animate { opacity: 1}, 'slow'

  ad.runBreakpoints = ->
    if matchMedia('only screen and (min-width: 750px)').matches
      ad.replaceVideo()
      ad.videoHeight()
      ad.replaceGifs()
    if matchMedia('only screen and (max-width: 750px)').matches
      ad.removeVideo()

  ad.videoHeight = ->
    # w_height = $(window).height()
    # nav_adjustment = 162
    # #when we drop the padding for mobile, this can be a matchmedia query
    # v_dimension = w_height - nav_adjustment
    # $('.videoContainer').height v_dimension
  ad.runBreakpoints()

  $(window).resize ->
    ad.runBreakpoints()
    ad.heroCenter()

  $('a.learn-more').click ->
    heroOffset = $('.hero .videoContainer').height() - 70
    $('body').stop().animate { scrollTop: heroOffset }, 650

  $(window).scroll ->
    height = $(window).scrollTop()
    if (height > 1000)
      $('.fixed-footer-bg').css "display" , "block"
    if (height <= 1000)
      $('.fixed-footer-bg').css "display" , "none"
  # $('.shape.hover').hover ->
  #   console.log ad
  #   ad['svg_hover_original'] = $(this).find('use').attr('xlink:href')
  #   if typeof $(ad['svg_hover_original']).find('g').first().attr('fill') != typeof undefined && $(ad['svg_hover_original']).find('g').first().attr('fill') != false
  #     ad['svg_hover_fillval'] = $(ad['svg_hover_original']).find('g').first().attr('fill')
  #   $(ad['svg_hover_original']).find('g').first().attr('fill', '')
  # , ->
  #   $(ad['svg_hover_original']).find('g').first().attr('fill', ad['svg_hover_fillval'])


  # didScroll = null
  # lastScrollTop = 0
  # scrollDelta = 5
  # $nav = $('.main-nav, .mobile-nav')
  # navbarHeight = $nav.outerHeight()
  #
  # $(window).on "scroll", (event) ->
  #   didScroll = true
  #
  # setInterval ->
  #   if didScroll
  #     hasScrolled()
  #     didScroll = false
  # , 250
  #
  # hasScrolled = ->
  #   # https://medium.com/@mariusc23/hide-header-on-scroll-down-show-on-scroll-up-67bbaae9a78c
  #   top = $(this).scrollTop()
  #   return false if Math.abs(lastScrollTop - top) <= scrollDelta
  #   if top > navbarHeight
  #     $nav.addClass('detached') if !$nav.hasClass('detached')
  #   if top <= 0
  #     $nav.removeClass('detached')
  #   if top > lastScrollTop && top > navbarHeight
  #     $nav.removeClass('nav-down').addClass('nav-up')
  #   else
  #     if top + $(window).height() < $(document).height()
  #       $nav.removeClass('nav-up').addClass('nav-down')
  #   lastScrollTop = top


  $('.menu-burger, .menu-items').on 'click', ->
    $('.menu-bg, .menu-items, .menu-burger, .mobile-nav .logo').toggleClass 'fs'
    $('body').toggleClass('overflow')
    if $('.menu-burger').text() == '☰' then $('.menu-burger').text('✕') else $('.menu-burger').text('☰')

  $('.tooltip-active').tooltip()



  $('g[id^="btn"]').hover(
   ->
     #target = $(this).attr('class').replace("step", "btn")
     $('g#btn-1').attr("class", "step-1") if $('g#btn-1').attr("class", "step-1 active")
     $('g[id^="btn"]').tooltip('hide')
     $(this).tooltip('show')
   , ->
     #target = $(this).attr('class').replace("step", "btn")
     $(this).tooltip('hide')
  )

  $("#btn-1").tooltip
    html: true,
    container: 'body',
    template: '<div class="tooltip blue active" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'

  $("#btn-2").tooltip
    html: true,
    container: 'body',
    template: '<div class="tooltip blue" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'
    # content: $("<h4>Automate sales</h4><p>Enable your sales organization to sell directly to customers. When you’re ready to build a sales team, AppDirect enables them with the tools to bill on behalf of customers.</p>")

  $("#btn-3").tooltip
    html: true,
    container: 'body',
    template: '<div class="tooltip blue" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'

  $("#btn-4").tooltip
    html: true,
    container: 'body',
    template: '<div class="tooltip blue" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'

  $("#btn-5").tooltip
    html: true,
    container: 'body',
    template: '<div class="tooltip blue" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'

  $("#btn-6").tooltip
    html: true,
    container: 'body',
    template: '<div class="tooltip blue" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'
