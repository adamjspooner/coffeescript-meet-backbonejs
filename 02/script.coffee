# ##Binding DOM Events to View Methods

# So, [part one](/01/docs/script.html) was pretty boring. Let's spice it up by 
# binding DOM events to our view's methods. [The implementation](../) of this 
# step is slighlty more exciting than the last.

#
jQuery ->
  
  class ListView extends Backbone.View
    
    el: $ 'body'
    
    initialize: ->
      _.bindAll @, 'render', 'addItem'
      @counter = 0
      @render()
    
    # We'll add a button and an empty list to our view.
    render: ->
      $(@el).append '<button>Add List Item</button>'
      $(@el).append '<ul></ul>'
    
    # `addItem()` will be called via the `click` event on the button we added
    # in our `render` method.
    addItem: ->
      @counter++
      $('ul').append "<li>Hello, Backbone #{@counter}!</li>"
    
    # [`events`](http://documentcloud.github.com/backbone/#View-delegateEvents) 
    # is a JSON object where DOM events are bound to view methods. Backbone 
    # doesn't have a separate controller to handle event bindings; it all
    # happens in a view.
    events: 'click button': 'addItem'
  
  
  list_view = new ListView

# Onward to [Part 3](/03/docs/script.html).
