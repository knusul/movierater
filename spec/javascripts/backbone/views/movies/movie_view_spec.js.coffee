//= require jquery
//= require jquery_ujs
//= require jquery.raty
//= require twitter/bootstrap
//= require turbolinks
//= require underscore
//= require backbone
//= require backbone.marionette
//= require backbone_rails_sync
//= require backbone_datalink
//= require backbone/movierater


describe "MovieView#render", ->
  it "updates contains star ratings", ->
    movie = new Movierater.Models.Movie
      id: 1
    view = new Movierater.Views.Movies.MovieView({model : movie})
    assert.lengthOf($(view.render().el).find("div.ratyrating"), 1, "Pah element does not exist")
