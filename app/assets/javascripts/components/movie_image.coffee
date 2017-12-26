#= require api_clients/movie_images

class MoviesJS.Components.MovieImage extends MoviesJS.Lib.UIComponent
  _initVariables: ->
    @id = @$container.attr('data-id')
    @$deleteButton = @$container.find('.js-delete')

  _initEventListeners: ->
    @$deleteButton.on 'click', @requestDestroy

  requestDestroy: =>
    @$container.addClass('-processing')
    MoviesJS.ApiClients.MovieImages.destroy(@id).success(@onDestroy)

  onDestroy: =>
    @$container.remove()
    $("input[name='movie[image_ids][]'][value='#{@id}']").remove()


