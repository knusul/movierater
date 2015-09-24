class Movierater.Models.Movie extends Backbone.Model
  paramRoot: 'movie'

  defaults:
    title: null
    description: null
    rating: 0
    totalRating: 0

class Movierater.Collections.MoviesCollection extends Backbone.Collection
  model: Movierater.Models.Movie
  url: '/movies'
