$ ->
  window.MyApp = new Backbone.Marionette.Application()
  MyApp.on('start', ->
    window.router = new Movierater.Routers.MoviesRouter()
    Backbone.history.start()
  )
  MyApp.start()
