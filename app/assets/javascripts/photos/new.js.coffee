$ ->
  uploader = $("#s3_uploader").S3Uploader
    remove_completed_progress_bar: false
    progress_bar_target: $("#uploads_container"),
    allow_multiple_files: true,
    additional_data: { album_id: $('#album_id option:selected').val() }

  $("#s3_uploader").bind "s3_upload_failed", (e, content) ->
    alert content.filename + " failed to upload"

  $('#s3_uploader').bind "s3_uploads_complete", (e, data) ->
    alert "All uploads are complete"

  $('#s3_uploader').bind 's3_uploads_start', (e) ->
    console.log($('#album_id').val())
    uploader.additional_data({album_id: $('#album_id').val()})

  return

$('#album_id').change(->
  uploader.additional_data($('#album_id').val())
)