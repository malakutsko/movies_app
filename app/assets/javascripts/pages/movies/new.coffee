#= require components/images_upload_form

class MoviesJS.Pages.MoviesNew extends MoviesJS.Lib.Page
  _initUI: ->
    new MoviesJS.Components.ImagesUploadForm(container: $('.js-images-upload-form'))
