#= require_tree ../pages

$(document).on 'turbolinks:load', ->
  new MoviesJS.Pages.MoviesEdit(container: $('.js-movies-edit'))
  new MoviesJS.Pages.MoviesNew(container: $('.js-movies-new'))
