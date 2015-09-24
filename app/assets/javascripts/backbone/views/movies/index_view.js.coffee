Movierater.Views.Movies ||= {}

class Movierater.Views.Movies.IndexView extends Backbone.View
  template: JST["backbone/templates/movies/index"],
  events:
    "change #search-category": "search"

  flush: () ->
    @$("tbody").html("")

  search: () ->
    @collection.fetch({data: {category: $("#search-category").val()}}).then =>
      @flush()
      @addAll()

  setCategories: ->
    @categories = _(@collection.pluck('category')).compact()
    @categories = _(@categories).uniq()
    _(@categories).each (category) =>
      @$('#search-category').append("<option value='#{category}'>#{category}</category>")

  initialize: () ->
    @collection.fetch(
      reset: true
    ).then =>
      @setCategories()

    @collection.bind('reset', @addAll)

  addAll: () =>
    @collection.each(@addOne)

  addOne: (movie) =>
    view = new Movierater.Views.Movies.MovieView({model : movie})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(movies: @collection.toJSON() ))
    return this
