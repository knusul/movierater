Movierater.Views.Movies ||= {}

class Movierater.Views.Movies.ShowView extends Backbone.View
  template: JST["backbone/templates/movies/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
