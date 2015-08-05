(function() {
  $(function() {
    var ad;
    ad = ad || {};
    window.sr = new scrollReveal;
    $('#graph g[id^="btn"]').hover(function() {
      var target;
      target = $(this).attr('class');
      $('g[class^="step"]').not("." + target).find("path, polygon").css('fill', '#e6e7e7');
      $('#top-icons g[class^="step"]').not(this).find("path, polygon").css('fill', 'transparent');
      $("." + target).find("path, polygon").css('fill', '#133a4e');
      return $("." + target).find(".ring").css("transform", "rotate(180deg)");
    }, function() {
      var target;
      target = $(this).attr('class');
      $('g[class^="step"]').find("path, polygon").css('fill', '');
      return $("." + target).find(".ring").css("transform", "rotate(360deg)");
    });
    $.get("/assets_new/svg/shapes.svg", function(data) {
      var div;
      div = document.createElement("div");
      div.className = "svgstore";
      div.innerHTML = new XMLSerializer().serializeToString(data.documentElement);
      return document.body.insertBefore(div, document.body.childNodes[0]);
    });
    $('.ga_push').on("click", function() {
      var text;
      text = $(this).attr("data-eventname");
      return _gaq.push(['_trackEvent', text]);
    });
    $(window).stellar();
    ad.removeVideo = function() {
      if ($('#headerVid').length > 0) {
        return $('#headerVid').remove();
      }
    };
    ad.replaceVideo = function() {
      if ($('#headerVid').length === 0) {
        $('.videoContainer').append($('<video class="video" id="headerVid" loop="true" muted="true" poster="imgs/video_placeholder.jpg" autoplay="true" ><!--autobuffer="true"--> <source src="https://embed-ssl.wistia.com/deliveries/12fa668b6ff07f77e39a0dec96e56c3fc85248ee/file.mp4" type="video/mp4" media="all and (min-width: 600px)"> </video>'));
        return $('.video').animate({
          opacity: 1
        }, 'slow');
      }
    };
    ad.runBreakpoints = function() {
      if (window.matchMedia('only screen and (min-width: 750px)').matches) {
        ad.replaceVideo();
        ad.videoHeight();
      }
      if (window.matchMedia('only screen and (max-width: 750px)').matches) {
        return ad.removeVideo();
      }
    };
    ad.videoHeight = function() {};
    ad.runBreakpoints();
    $(window).resize(function() {
      return ad.runBreakpoints();
    });
    $('.menu-burger, .menu-items').on('click', function() {
      $('.menu-bg, .menu-items, .menu-burger').toggleClass('fs');
      if ($('.menu-burger').text() === '☰') {
        return $('.menu-burger').text('✕');
      } else {
        return $('.menu-burger').text('☰');
      }
    });
    $('.tooltip').tooltipster({
      trigger: 'hover'
    });
    $('g[id^="btn"]').hover(function() {
      return $(this).tooltipster('show');
    }, function() {
      return $(this).tooltipster('hide');
    });
    $("#btn-1").tooltipster({
      theme: 'blue-tooltip',
      content: $("<h4>Self-service Billing</h4><p>Bill for your cloud services on your own website. Ideal for startups that need a powerful yet cost-effective billing solution.</p>")
    });
    $("#btn-2").tooltipster({
      theme: 'blue-tooltip',
      content: $("<h4>Billing for Assisted Sales</h4><p>Enable your sales organization to sell directly to customers. When you’re ready to build a sales team, AppDirect enables them with the tools to bill on behalf of customers.</p>")
    });
    $("#btn-3").tooltipster({
      theme: 'blue-tooltip',
      content: $("<h4>Affiliates & Referral Programs</h4><p>Use referral and affiliate management to monetize your leads. Easily create and manage indirect sales programs to drive even more revenue.</p>")
    });
    $("#btn-4").tooltipster({
      theme: 'blue-tooltip',
      content: $("<h4>Reseller and VAR Management</h4><p>Let third-party resellers sell your products. Expand your indirect sales channel more by enabling resellers.</p>")
    });
    $("#btn-5").tooltipster({
      theme: 'blue-tooltip',
      content: $("<h4>List in App Marketplaces</h4><p>List your products in third-party marketplaces around the globe. Drive global adoption of your applications by distributing them via marketplaces operated by trusted companies worldwide.</p>")
    });
    return $("#btn-6").tooltipster({
      theme: 'blue-tooltip',
      content: $("<h4>List in App Marketplaces</h4><p>List your products in third-party marketplaces around the globe. Drive global adoption of your applications by distributing them via marketplaces operated by trusted companies worldwide.</p>")
    });
  });

}).call(this);

(function() {
  $(function() {
    var adjustPhotoHeight, customPhotoPagination, photoSlide;
    $('#photo-carousel').owlCarousel({
      navigation: false,
      slideSpeed: 300,
      lazyLoad: true,
      singleItem: true,
      pagination: true,
      afterInit: function(elem) {
        var that;
        that = this;
        return that.owlControls.appendTo('.photo-carousel .photo-description');
      }
    });
    photoSlide = $('#photo-carousel').data('owlCarousel');
    $('.photo-prev').click(function() {
      return photoSlide.prev();
    });
    $('.photo-next').click(function() {
      return photoSlide.next();
    });
    customPhotoPagination = function() {
      var index, target;
      target = $(e.target);
      index = $('.custom-slide span').index(target);
      return photoSlide.goTo(index);
    };
    adjustPhotoHeight = function() {
      var photoHeight;
      if ($(window).width() >= 1024) {
        photoHeight = $('#photo-carousel').height();
        $('.photo-description').css("height", photoHeight + "px");
      }
      if ($(window).width() < 1024) {
        return $('.photo-description').css("height", "auto");
      }
    };
    adjustPhotoHeight();
    $(window).resize(function() {
      return adjustPhotoHeight();
    });
    $('#photo-carousel, .arrow svg').on("mouseover", function() {
      return $('.arrow svg').css('opacity', '0.5');
    });
    return $('#photo-carousel, .arrow svg').on("mouseleave", function() {
      return $('.arrow svg').css('opacity', '0');
    });
  });

}).call(this);

(function() {
  $(function() {
    var customVideoPagination, emptyIframe, loadWistia, resizeControls, videoSlide;
    $('.video-placeholder').owlCarousel({
      navigation: false,
      slideSpeed: 300,
      lazyLoad: true,
      paginationSpeed: 400,
      singleItem: true,
      mouseDrag: false,
      touchDrag: false,
      pagination: false
    });
    videoSlide = $('.video-placeholder').data('owlCarousel');
    customVideoPagination = function() {
      return $('.custom-slide img').click(function(e) {
        var buttonTitle, display, index, target;
        target = $(e.target);
        index = $('.custom-slide img').index(target);
        display = $('.slide')[index];
        buttonTitle = $(this).attr('title');
        $(this).parent().siblings().children().removeClass('active');
        $(this).addClass('active');
        $('.active-on').removeClass('on');
        $(this).siblings().addClass('on');
        videoSlide.goTo(index);
        $(display).fadeIn('slow');
        $(display).siblings().hide();
        $(display).children().fadeIn('slow');
        return $('button.video-launch').attr('title', buttonTitle);
      });
    };
    customVideoPagination();
    resizeControls = function() {
      var iframeHeight;
      iframeHeight = $(".iframe-container iframe").height();
      return $('.video-modal.in .controls').css("height", iframeHeight + "px");
    };
    resizeControls();

    /*
     * Welcome to the new js2coffee 2.0, now
     * rewritten to use the esprima parser.
     * try it out!
     */
    $(window).resize(function() {
      return resizeControls();
    });
    loadWistia = function(wistiaEmbed) {
      return $('.video-launch').click(function() {
        var loadedIframe;
        wistiaEmbed = $(this).attr('title');
        loadedIframe = $('.iframe-container').html('<iframe src="//fast.wistia.net/embed/iframe/' + wistiaEmbed + '?videoFoam="true" allowtransparency="true" frameborder="0" scrolling="no" id="wistia_video" class="wistia_embed" name="wistia_embed" allowfullscreen mozallowfullscreen webkitallowfullscreen oallowfullscreen msallowfullscreen width="1280" height="720"></iframe>');
        return $(loadedIframe).appendTo('.iframe-container').hide().append(loadedIframe).fadeIn('fast');
      });
    };
    loadWistia();
    $('.video-launch , button.video-launch').click(function() {
      $('.video-modal').modal();
      return setTimeout(resizeControls, 200);
    });
    emptyIframe = function() {
      return $('.iframe-container').empty();
    };
    $('span.close').click(function() {
      return emptyIframe();
    });
    return $(document).keydown(function(e) {
      if (e.keyCode === 27) {
        return $('.video-modal').modal().close();
      }
    });
  });

}).call(this);
