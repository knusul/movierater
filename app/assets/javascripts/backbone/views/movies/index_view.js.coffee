Movierater.Views.Movies ||= {}

class Movierater.Views.Movies.IndexView extends Backbone.View
  template: JST["backbone/templates/movies/index"],

  initialize: () ->
    @collection.reset()
    @collection.fetch
      reset: true
    @collection.bind('reset', @addAll)

  addAll: () =>
    @collection.each(@addOne)

  addOne: (movie) =>
    view = new Movierater.Views.Movies.MovieView({model : movie})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(movies: @collection.toJSON() ))
    return this
