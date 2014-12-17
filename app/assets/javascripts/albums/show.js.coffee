$ ->
  $('#albums img').click( ->
      $("#lightbox-image").attr('src', $(this).data('image-large'))
      $('#next-photo').data('index', $(this).data('index'))
  )

  $('#next-photo').click( ->
    next_photo_index = parseInt($(this).data('index')) + 1

    if $('img[data-index="' + next_photo_index + '"]').length > 0 #if you can find a next image index, show it
      $("#lightbox-image").attr('src', $('img[data-index="' + next_photo_index + '"]').data('image-large'))
      $(this).data('index', $('img[data-index="' + next_photo_index + '"]').data('index')) #change button data-index to new data-index
    else #else, try and find the one with index zero
      $("#lightbox-image").attr('src', $('img[data-index="0"]').data('image-large'))
      $(this).data('index', 0)
  )

  # knowns: array index of current image

  # if you can find image with index of current image index + 1 
  #   change to that image 
  # else
  #   change to index 0 image 
  # end