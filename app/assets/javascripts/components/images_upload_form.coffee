class MoviesJS.Components.ImagesUploadForm extends MoviesJS.Lib.UIComponent
  _initVariables: ->
    @$realUploadButton = @$container.find('#movie_image_attachment')
    @$fakeUploadButton = @$container.find('.js-upload-button')
    @$imagesContainer = @$container.find('.js-images-container')
    @$imageTemplate = $('#image_template').val()
    @$movieForm = $('.js-movie-form')

  _initUI: ->
    @initFileUpload()

  _initEventListeners: ->
    @$fakeUploadButton.on 'click', @clickOnRealUploadButton

  clickOnRealUploadButton: (e) =>
    e.preventDefault()
    @$realUploadButton.trigger('click')

  initFileUpload: =>
    @$container.find('input:file').each (i, elem) =>
      fileInput = $(elem)
      fileInput.fileupload
        fileInput: fileInput
        type: 'POST'
        autoUpload: true
        formData: '#'
        paramName: 'file'
        url: @$container.data('bucket-url')
        dataType: 'XML'
        replaceFileInput: false
        maxNumberOfFiles: 20
        acceptFileTypes: /(\.|\/)(jpe?g|png)$/i
        add: @sendPresignedPost
        done: @markImageUploaded
        fail: (e, data) -> console.log(e)

   sendPresignedPost: (e, data) =>
     dataURL = URL.createObjectURL(data.files[0])
     $.ajax
       url: @$container.attr('action')
       data:
         file_size: data.files[0].size
         content_type: data.files[0].type
         file_name: data.files[0].name
       type: 'POST'
       success: (response) =>
         @displayImage(response.id, dataURL)
         data.formData = response.form_data
         data.submit()

   displayImage: (id, url) =>
     $newImage = $(@$imageTemplate)
     @$imagesContainer.append($newImage)
     $newImage.css 'background-image': "url('#{url}')"
     $newImage.addClass('-processing')
     $newImage.attr('data-id', id)
     @$movieForm.append("<input type='hidden' name='movie[image_ids][]' value=#{id}>")

   markImageUploaded: (e, data) ->
     imageId = data.formData.key.match(/^uploads\/movie_images\/(\d+)/)[1]
     $(".js-movie-image[data-id=#{imageId}]").removeClass('-processing')
