# ##Using a Dedicated View for a Model

# We added a model and collection in the 
# [previous example](/03/docs/script.html), but our main application view 
# still held the structure for our model. We'll add a dedicated view, 
# `ItemView`, for our `Item` model. [The implementation](../) for this part 
# looks exactly the same as the [implementation of Part 3](/03/).

#
jQuery ->
  
  class Item extends Backbone.Model
    
    defaults:
      part1: 'Hello'
      part2: 'Backbone'
  
  
  class List extends Backbone.Collection
    
    model: Item
  
  
  # The `ItemView` is now responsible for rendering each `Item`.
  class ItemView extends Backbone.View
    
    # `tagName` is used to create our
    # [`@el`](http://documentcloud.github.com/backbone/#View-el). You can also
    # add `className` and `id` properties, but `tagName` is enough for this
    # simple example.
    tagName: 'li'
    
    initialize: ->
      _.bindAll @
    
    render: ->
      $(@el).html "<span>#{@model.get 'part1'} #{@model.get 'part2'}!</span>"
      # Returning `@` is considered a good practice. It let's us chain method 
      # calls (i.e., `item_view.render().el`).
      @
  
  
  class ListView extends Backbone.View
    
    el: $ 'body'
    
    initialize: ->
      _.bindAll @
      
      @collection = new List
      @collection.bind 'add', @appendItem
      
      @counter = 0
      @render()
    
    render: ->
      $(@el).append '<button>Add List Item</button>'
      $(@el).append '<ul></ul>'
    
    addItem: ->
      @counter++
      item = new Item
      item.set part2: "#{item.get 'part2'} #{@counter}"
      @collection.add item
    
    # `appendItem()` no longer renders an individual `Item`. Rendering is 
    # delegated to the `render()` method of each `ItemView` instance.
    appendItem: (item) ->
      # Instantiate a new `ItemView` using `item` as the `model`.
      item_view = new ItemView model: item
      $('ul').append item_view.render().el
    
    events: 'click button': 'addItem'
  
  
  list_view = new ListView

# Onward to [Part 5](/05/docs/script.html)
