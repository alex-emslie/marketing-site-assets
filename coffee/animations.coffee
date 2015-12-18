$(window).scroll ->
  if $(this).scrollTop() >= $('#trigger1').offset().top - 200
    $('#GREEN_CIRCLE, #BLUE_CIRCLE').attr "class", "zap"


hoverBox = ->
  infoBox = ".info-box .right .content"
  staticText = "<h1>An end-to-end solution for consumer and SMB segments.</h1><p>AppDirect eliminates the risk of delivering premium tech support to your end users with complete solution packages that              include call center resources, software, and technology and operational expertise.</p></br><p>Our four configurable offerings, for home and business, let you choose the right support for your customers’ needs so everyone can rest at ease.</p>"
  consumerText = "<h1>A white-label technical support solution for all home technology.</h1>
      					  <ul><h3>Consumer Technical Support Benefits</h3><li>Onboarding, setup and configuration for all IoT devices</li><li>Cross-sell and up-sell additional services via expert agents</li><li>Full stack support regardless of manufacturer or problem</li><li>Cost effective support with shared pool of agents</li></ul>"
  businessText = "<h1>Enterprise-grade support for any hardware, software or cloud IT challenge.</h1>
      					  <ul><h3>Business IT Helpdesk Benefits</h3><li>Deliver at Point-of-Need, Point-of-Sale or as bundles</li><li>Includes live chat, remote login, intelligent routing</li><li>Offer additional services like security, backup, and recovery</li><li>Low cost subscription pricing with full-scope assistance</li></ul>"
  marketplaceText = "<h1>White label marketplace support that drives user engagement.</h1>
      					  <ul><h3>Marketplace Technical Support Benefits</h3><li>First line of support to discover and buy cloud services</li><li>Voice and online chat services delivered by expert agents</li><li>Cross-sell and up-sell additional apps and support services</li><li>Go-to-market faster and increase Gross Merchandise Value </li></ul>"
  docText = "<h1>Onboarding, activation and professional services for SMBs with Office 365.</h1>
      					  <ul><h3>Cloud Services Support for Office 365 Benefits</h3><li>Onboarding, activation, migration for O365 users</li><li>Fast onboarding with zero user downtime</li><li>Front line support from our expert technicians</li><li>On-going support for provisioning and administrative issues</li></ul>"

  $('.box.consumer').on
    'click': ->
      $(infoBox).html(consumerText)
      $('.info-box .box').removeClass('active')
      $(this).addClass('active')
  $('.box.business').on
    'click': ->
      $(infoBox).html(businessText)
      $('.info-box .box').removeClass('active')
      $(this).addClass('active')
  $('.box.marketplace').on
    'click': ->
      $(infoBox).html(marketplaceText)
      $('.info-box .box').removeClass('active')
      $(this).addClass('active')
  $('.box.doc').on
    'click': ->
      $(infoBox).html(docText)
      $('.info-box .box').removeClass('active')
      $(this).addClass('active')

hoverBox()

# Cache selectors
lastId = undefined
topMenu = $('#button-selector')
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
