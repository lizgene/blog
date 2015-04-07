$ ->
  $("#emailModal").on "show.bs.modal", (event) ->
    $('.share-popover').popover('hide')