Movierater.Views.Movies ||= {}

class Movierater.Views.Movies.MovieView extends Backbone.View
  template: JST["backbone/templates/movies/movie"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    @$el.find('.ratyrating').raty
      path: 'assets/',
      score: @model.get('rating')
    return this
