# ##Using a Collection of Models

# So far we've used the view as our view and model. We'll extend
# Backbone.Model and Backbone.Collection to separate our model from our view.

# You might want to [view the implementation](../) of this step before 
# diving in.

#
jQuery ->
  
  # The [model](http://documentcloud.github.com/backbone/#Model) is the heart 
  # of any application. We have a very small heart in this example.
  class Item extends Backbone.Model
    
    # [`defaults`](http://documentcloud.github.com/backbone/#Model-defaults) 
    # is a JSON object used to specify the default attributes for our model.
    defaults:
      part1: 'Hello'
      part2: 'Backbone'
  
  
  # Our [collection](http://documentcloud.github.com/backbone/#Collection) is 
  # an ordered set of the previously defined `Item`s.
  class List extends Backbone.Collection
    
    model: Item
  
  
  class ListView extends Backbone.View
    
    el: $ 'body'
    
    # `initialize()` now instantiates a collection and binds the 
    # [`add`](http://documentcloud.github.com/backbone/#Collection-add) event 
    # to the `appendItem()` method.
    initialize: ->
      _.bindAll @, 'render', 'addItem', 'appendItem'
      
      @collection = new List
      @collection.bind 'add', @appendItem
      
      @counter = 0
      @render()
    
    render: ->
      $(@el).append '<button>Add List Item</button>'
      $(@el).append '<ul></ul>'
    
    # `addItem()` now deals solely with models/collections. View updates are 
    # delegated to the `add` event bound to `appendItem()` when we 
    # `initialize`ed our list_view.
    addItem: ->
      @counter++
      
      # Instantiate a new Item,
      item = new Item
      # and modify its second part.
      item.set part2: "#{item.get 'part2'} #{@counter}"
      # Then, add it to our collection.
      @collection.add item
    
    # `appendItem()` is triggered by the collection event `add` and handles 
    # updates to the interface.
    appendItem: (item) ->
      $('ul').append "<li>#{item.get 'part1'} #{item.get 'part2'}!</li>"
    
    events: 'click button': 'addItem'
  
  
  list_view = new ListView

# Onward to [Part 4](/04/docs/script.html)
