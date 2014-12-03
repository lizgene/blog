$ ->

  # $("#photos").change ->
  #   console.log("change")
  #   $(".direct-upload").find("input:file").each (i, elem) ->
  #     fileInput = $(elem)
  #     form = $(fileInput.parents("form:first"))
  #     submitButton = form.find("input[type=\"submit\"]")
  #     progressBar = $("<div class='bar'></div>")
  #     barContainer = $("<div class='progress'></div>").append(progressBar)
  #     fileInput.after barContainer


  #     fileInput.fileupload
  #       fileInput: fileInput
  #       url: $("#s3_direct_post_url").val()
  #       type: "POST"
  #       autoUpload: true
  #       formData: $("#s3_direct_post_fields").val()
  #       paramName: "file" # S3 does not like nested name fields i.e. name="user[avatar_url]"
  #       dataType: "XML" # S3 returns XML if success_action_status is set to 201
  #       replaceFileInput: false
  #       progressall: (e, data) ->
  #         progress = parseInt(data.loaded / data.total * 100, 10)
  #         progressBar.css "width", progress + "%"
  #         return

  #       start: (e) ->
  #         submitButton.prop "disabled", true
  #         progressBar.css("background", "green").css("display", "block").css("width", "0%").text "Loading..."
  #         return

  #       done: (e, data) ->
  #         submitButton.prop "disabled", false
  #         progressBar.text "Uploading done"
          
  #         # extract key and generate URL from response
  #         key = $(data.jqXHR.responseXML).find("Key").text()
  #         console.log(key)
  #         host = $('#s3_direct_post_url_host').val()
  #         url = "//#{host}/" + key
          
  #         # create hidden field
  #         input = $("<input />",
  #           type: "hidden"
  #           name: fileInput.attr("name")
  #           value: url
  #         )
  #         form.append input
  #         return

  #       fail: (e, data) ->
  #         submitButton.prop "disabled", false
  #         progressBar.css("background", "red").text "Failed"
  #         return

  #     return

