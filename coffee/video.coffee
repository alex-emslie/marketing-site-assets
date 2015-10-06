$ ->

  # resizeVideoInfo = ->
  #   infoSize = $('.video-placeholder').height()
  #   $('.video-container .info').css "height", infoSize + "px"
  #
  # resizeVideoInfo()

  $('.video-placeholder').owlCarousel
    navigation: false
    slideSpeed: 300
    lazyLoad: true
    paginationSpeed: 400
    singleItem: true
    mouseDrag: false
    touchDrag: false
    pagination: false

  videoSlide = $('.video-placeholder').data('owlCarousel')

  customVideoPagination = ->
    $('.custom-slide img').click (e)->
      target = $(e.target)
      index = $('.custom-slide img').index(target)
      display = $('.slide')[index]
      buttonTitle = $(this).attr('title')
      $(this).parent().siblings().children().removeClass('active')
      $(this).addClass('active')
      $('.active-on').removeClass('on')
      $(this).siblings().addClass('on')
      videoSlide.goTo index
      $(display).fadeIn('slow')
      $(display).siblings().hide()
      $(display).children().fadeIn('slow')
      $('button.video-launch').attr('title' , buttonTitle)
      if matchMedia('only screen and (max-width: 1199px)').matches
        if index == 0 or index == 4
          $('button.video-launch').css("display" , "none")
        else
          $('button.video-launch').css("display" , "block")

  customVideoPagination()

  resizeControls = ->
    iframeHeight = $(".iframe-container iframe").height()
    $('.video-modal.in .controls').css "height", iframeHeight + "px"

  resizeControls()

  # Reposition when a modal is shown

  ###
  # Welcome to the new js2coffee 2.0, now
  # rewritten to use the esprima parser.
  # try it out!
  ###

  # reposition = ->
  #   modal = $(this)
  #   dialog = modal.find('.modal-dialog')
  #   iframeHeight = $(".iframe-container iframe").height()
  #   modal.css 'display', 'block'
  #   # Dividing by two centers the modal exactly, but dividing by three
  #   # or four works better for larger screens.
  #   dialog.css 'margin-top', Math.max(0, ($(window).height() - iframeHeight) / 2)
  #   console.log(iframeHeight)
  #
  # if $(window).width() >= 820
  #   $('.video-modal').on 'load', reposition


  $(window).resize ->
    resizeControls()
    if matchMedia('only screen and (min-width: 1200px)').matches
      $('button.video-launch').css("display" , "none")

  loadWistia = (wistiaEmbed) ->
    $('.video-launch, button.video-launch').click (e) ->
      e.preventDefault()
      return false if $('html').hasClass('ie8')
      wistiaEmbed = $(this).attr('title')
      loadedIframe = $('.iframe-container').html('<iframe src="//fast.wistia.net/embed/iframe/' + wistiaEmbed + '?videoFoam=true" allowtransparency="true" frameborder="0" scrolling="no" id="wistia_video" class="wistia_embed" name="wistia_embed" allowfullscreen mozallowfullscreen webkitallowfullscreen oallowfullscreen msallowfullscreen width="1920" height="1080"></iframe>')
      $(loadedIframe).appendTo('.iframe-container')
      $('.video-modal').modal()
      # $('.iframe-container iframe').on "load", ->
      #   $('.iframe-placeholder').css "opacity" , "0"
  loadWistia()


  emptyIframe = ->
    $('.iframe-container').empty()

  $('span.close').click ->
    emptyIframe()
