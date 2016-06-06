# ##Extending Backbone.View

# First, we'll extend 
# [Backbone.View](http://documentcloud.github.com/backbone/#View) to create a
# very minimal unordered list view. Take a look at [the implementation](../)
# of this step so you'll know what we're building.

# The `jQuery` wrapper isn't necessary since we know this script is called
# after jQuery has been included, but it explicitly shows our dependence 
# on jQuery. Clarity is a good thing.
jQuery ->
  
  # Our main application view.
  class ListView extends Backbone.View
    
    # We'll be using the `body` element for our view in all our examples. All 
    # views have a DOM element at all times. 
    # [`el`](http://documentcloud.github.com/backbone/#View-el) is our view's
    # connetion to the DOM.
    el: $ 'body'
    
    # [`initialize()`](http://documentcloud.github.com/backbone/#View-constructor) 
    # is automatically called upon instantiation.
    initialize: ->
      # We're using [Underscore.js's bindAll method](http://documentcloud.github.com/underscore/#bindAll) 
      # to bind all the view's methods to this instance of our view.
      _.bindAll @
      @render()
    
    # `render()` renders the view in `@el`. It must be called by us; 
    # we called it at the end of our `initialize()` function.
    render: ->
      $(@el).append '<ul><li>Hello, Backbone!</li></ul>'
  
  
  # Lastly, we instantiate our main app view.
  list_view = new ListView

# Onward to [Part 2](/02/docs/script.html).
