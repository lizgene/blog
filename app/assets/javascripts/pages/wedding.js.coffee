$ ->
  affixHeader()
  initFilter()

affixHeader = ->
  $('#wedding-header').affix(
    offset: 
      top: $('#wedding-header').position().top + 20
      bottom: $('#wedding-header').position().bottom + 20
  )

initFilter = ->
  $('#filters li').click((e) ->
    e.preventDefault()

    filter = $(e.target).data('filter')
    # $(".category-nav").removeClass('active')
    # $(".category-nav.#{filter}").addClass('active')

    places_container = $('#places_container')
    places_container.fadeOut ->

      places = $('#places_container .place')
      _.each(places, (place) ->
        if $(place).hasClass(filter)
          $(place).removeClass('hidden')
        else
          $(place).addClass('hidden')
        )
      places_container.fadeIn()
  )