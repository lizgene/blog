$ ->
  $("#s3_uploader").S3Uploader
    remove_completed_progress_bar: false
    progress_bar_target: $("#uploads_container"),
    allow_multiple_files: true

  $("#s3_uploader").bind "s3_upload_failed", (e, content) ->
    alert content.filename + " failed to upload"

  $('#s3_uploader').bind "s3_uploads_complete", (e, data) ->
    alert "All uploads are complete"

  return


