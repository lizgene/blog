$ ->
  $('.lets-go').click( ->
      $("html, body").animate({ scrollTop: $(window).height()}, 600);
      return false;
  )