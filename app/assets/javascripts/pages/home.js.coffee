$ ->
  $('.homepage-section-header').click( ->
      $("html, body").animate({ scrollTop: $(window).height()}, 600);
      return false;
  )