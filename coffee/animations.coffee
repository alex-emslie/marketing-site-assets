fireCounter = true

if $('.js-animate-scroll')[0]
  console.log 'animated'
  $(window).scroll ->
    animateGraph = ->
      if fireCounter == true
        if $(this).scrollTop() >= $('#trigger1').offset().top - 500
          $('#GREEN_CIRCLE, #BLUE_CIRCLE').attr "class", "zap"
          $('.count').each ->
            $('#blue-text, #green-text').addClass('fade-number')
            $(this).prop('Counter', 0).animate { Counter: $(this).text() },
              duration: 1000
              step: (now) ->
                $(this).text Math.ceil(now)
          countDelay = ->
            $('.count-delay').each ->
              $('#green-text').addClass('fade-number')
              $(this).prop('Counter', 0).animate { Counter: $(this).text() },
                duration: 1000
                step: (now) ->
                  $(this).text Math.ceil(now)
          setTimeout countDelay, 250

          fireCounter = false

    animateClouds = ->
      if $(this).scrollTop() >= $('#trigger2').offset().top - 500
        $("#sun").attr "class", "bounceInUp animated"

    if $(this).scrollTop() >= $('#trigger3').offset().top - 500
      # animateBottom = ->
      #   $(".logo_bottom").attr "class", "bounceIn animated fast"
      # setTimeout animateBottom, 0
      # animateRight = ->
      #   $(".logo_right").attr "class", "bounceIn animated fast"
      # setTimeout animateRight, 100
      # animateLeft = ->
      #   $(".logo_left").attr "class", "bounceIn animated fast"
      # setTimeout animateLeft, 200
      animateBottom = ->
        $(".logo_bottom").animate {
          opacity: 0.9
          easing: "ease-in-out"
        }
      setTimeout animateBottom, 0
      animateRight = ->
        $(".logo_right").animate {
          opacity: 0.9
          easing: "ease-in-out"
        }
      setTimeout animateRight, 150
      animateLeft = ->
        $(".logo_left").animate {
          opacity: 0.9
          easing: "ease-in-out"
        }
      setTimeout animateLeft, 300

    animateGraph()
    animateClouds()

# hoverBox = ->
#   infoBox = ".info-box .right .content"
#   staticText = "<h1>An end-to-end solution for consumer and SMB segments.</h1><p>AppDirect eliminates the risk of delivering premium tech support to your end users with complete solution packages that              include call center resources, software, and technology and operational expertise.</p></br><p>Our four configurable offerings, for home and business, let you choose the right support for your customers’ needs so everyone can rest at ease.</p>"
#   consumerText = "<h1>A white-label technical support solution for all home technology.</h1>
#       					  <ul class='bullets'><h3>Consumer Technical Support Benefits</h3><li>Onboard, setup and configure IoT devices.</li><li>Cross-sell and up-sell additional services via expert agents.</li><li>Offer full-stack support regardless of manufacturer or problem.</li><li>Support is cost effective with a shared pool of agents.</li></ul>"
#   businessText = "<h1>Enterprise-grade support for any hardware, software or cloud IT challenge.</h1>
#       					  <ul class='bullets'><h3>Business IT Helpdesk Benefits</h3><li>Deliver at Point-of-Need, Point-of-Sale or as bundles.</li><li>Live chat, remote login, and intelligent routing are included.</li><li>Offer additional services like security, backup, and recovery.</li><li>Low cost subscription pricing with full-scope assistance.</li></ul>"
#   marketplaceText = "<h1>White label marketplace support that drives user engagement.</h1>
#       					  <ul class='bullets'><h3>Marketplace Technical Support Benefits</h3><li>Offer first line of support to cloud services discovery and purchasing.</li><li>Expert agents deliver voice and online chat services.</li><li>Cross-sell and up-sell additional apps and support services.</li><li>Go to market faster and increase Gross Merchandise Value.</li></ul>"
#   docText = "<h1>Onboarding, activation and professional services for SMBs with Office 365.</h1>
#       					  <ul class='bullets'><h3>Cloud Services Support for Office 365 Benefits</h3><li>Onboard, activate, and migrate Office 365 users.</li><li>Onboarding users quickly with zero downtime.</li><li>Expert technicians provide front line support.</li><li>Support for provisioning and administrative issues is on-going.</li></ul>"

#   $('.box.consumer').on
#     'click': ->
#       $(infoBox).html(consumerText)
#       $('.info-box .box').removeClass('active')
#       $(this).addClass('active')
#   $('.box.business').on
#     'click': ->
#       $(infoBox).html(businessText)
#       $('.info-box .box').removeClass('active')
#       $(this).addClass('active')
#   $('.box.marketplace').on
#     'click': ->
#       $(infoBox).html(marketplaceText)
#       $('.info-box .box').removeClass('active')
#       $(this).addClass('active')
#   $('.box.doc').on
#     'click': ->
#       $(infoBox).html(docText)
#       $('.info-box .box').removeClass('active')
#       $(this).addClass('active')

# hoverBox()

$('.info-box a').click (e) ->
  e.preventDefault()
  $this = $(this)
  contentBox = $('.content-box')
  infoBox = $('.info-box a')
  target = $this.attr('href')
  targetID = $(target)
  contentBox.removeClass 'active'
  targetID.addClass 'active'
  infoBox.removeClass 'active'
  $this.addClass 'active'

if $('.js-scroll-hook')[0]
  # Cache selectors
  lastId = undefined
  topMenu = $('.button-selector')
  menuItems = topMenu.find('a')
  scrollItems = menuItems.map(->
    item = $($(this).attr('href'))
    if item.length
      return item
  )
  # Bind click handler to menu items
  # so we can get a fancy scroll animation
  menuItems.click (e) ->
    href = $(this).attr('href')
    offsetTop = if href == '#' then 0 else $(href).offset().top - topMenu.outerHeight() - 65
    $('html, body').stop().animate { scrollTop: offsetTop }, 650
    e.preventDefault()
