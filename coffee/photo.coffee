$ ->
  $('#photo-carousel').owlCarousel
    navigation: false
    slideSpeed: 300
    lazyLoad: true
    singleItem: true
    pagination: true
    afterInit : (elem) ->
      that = this
      that.owlControls.appendTo('.photo-carousel .photo-description')

  photoSlide = $('#photo-carousel').data('owlCarousel')

  $('.photo-prev').click ->
    photoSlide.prev()
  $('.photo-next').click ->
    photoSlide.next()

  customPhotoPagination = ->
    target = $(e.target)
    index = $('.custom-slide span').index(target)
    photoSlide.goTo index

  adjustPhotoHeight = ->
    if $(window).width() >= 1024
      photoHeight = $('#photo-carousel').height()
      $('.photo-description').css "height", photoHeight + "px"
    if $(window).width() < 1024
      $('.photo-description').css "height", "auto"
  adjustPhotoHeight()

  $(window).resize ->
    adjustPhotoHeight()

  $('#photo-carousel, .arrow svg').on "mouseover", ->
    $('.arrow svg').css('opacity' , '0.5')
  $('#photo-carousel, .arrow svg').on "mouseleave", ->
    $('.arrow svg').css('opacity' , '0')
