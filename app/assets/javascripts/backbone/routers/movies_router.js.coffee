class Movierater.Routers.MoviesRouter extends Backbone.Router
  initialize: (options) ->
    @movies = new Movierater.Collections.MoviesCollection()
    @movies.reset options.movies

  routes:
    "new"      : "newMovie"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newMovie: ->
    @view = new Movierater.Views.Movies.NewView(collection: @movies)
    $("#movies").html(@view.render().el)

  index: ->
    @view = new Movierater.Views.Movies.IndexView(collection: @movies)
    $("#movies").html(@view.render().el)

  show: (id) ->
    movie = @movies.get(id)

    @view = new Movierater.Views.Movies.ShowView(model: movie)
    $("#movies").html(@view.render().el)

  edit: (id) ->
    movie = @movies.get(id)

    @view = new Movierater.Views.Movies.EditView(model: movie)
    $("#movies").html(@view.render().el)