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
      click: (score, event)=>
        @model.save("rating", score)
        @model.fetch().then =>
          @render()
    @$el.find('.ratytotalrating').raty
      path: 'assets/',
      score: @model.get('totalRating')
      readOnly: true
    return this
