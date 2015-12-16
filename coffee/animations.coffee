$(window).scroll ->
  if $(this).scrollTop() >= $('#trigger1').offset().top - 200
    $('#GREEN_CIRCLE, #BLUE_CIRCLE').attr "class", "zap"


hoverBox = ->
  infoBox = ".info-box .right .content"
  staticText = "<h1>An end-to-end solution for consumer and SMB segments.</h1>
      					<p>AppDirect takes out all the risk of delivering premium tech support to your end users with a complete solution that includes all the call center resources, software, technology and operational expertise you need.</p>"
  consumerText = "<h1>A white-label technical support solution for all home technology.</h1>
      					  <ul><h3>Consumer Technical Support Benefits</h3><li>Onboarding, setup and configuration for all IoT devices</li><li>Cross-sell and up-sell additional services via expert agents</li><li>Full stack support regardless of manufacturer or problem</li><li>Cost effective support with shared pool of agents</li></ul>"
  businessText = "<h1>Premium support for cloud services and connected devices for small and medium sized businesses.</h1>
      					  <ul><h3>Business IT Helpdesk Benefits</h3><li>Deliver at Point-of-Need, Point-of-Sale or as bundles</li><li>Includes live chat, remote login, intelligent routing</li><li>Offer additional services like security, backup, and recovery</li><li>Low cost subscription pricing with full-scope assistance</li></ul>"
  marketplaceText = "<h1>White label marketplace support that drives user engagement.</h1>
      					  <ul><h3>Marketplace Technical Support Benefits</h3><li>First line of support to discover and buy cloud services</li><li>Voice and online chat services delivered by expert agents</li><li>Cross-sell and up-sell additional apps and support services</li><li>Go-to-market faster and increase Gross Merchandise Value </li></ul>"
  docText = "<h1>Onboarding, activation and professional services for SMBs with Office 365.</h1>
      					  <ul><h3>Cloud Services Support for Office 365 Benefits</h3><li>Onboarding, activation, migration for O365 users</li><li>Fast onboarding with zero user downtime</li><li>Front line support from our expert technicians</li><li>On-going support for provisioning and administrative issues</li></ul>"

  $('.box.consumer').on
    'mouseenter': ->
      $(infoBox).html(consumerText)
    'mouseleave': ->
      $(infoBox).html(staticText)
  $('.box.business').on
    'mouseenter': ->
      $(infoBox).html(businessText)
    'mouseleave': ->
      $(infoBox).html(staticText)
  $('.box.marketplace').on
    'mouseenter': ->
      $(infoBox).html(marketplaceText)
    'mouseleave': ->
      $(infoBox).html(staticText)
  $('.box.doc').on
    'mouseenter': ->
      $(infoBox).html(docText)
    'mouseleave': ->
      $(infoBox).html(staticText)


hoverBox()
