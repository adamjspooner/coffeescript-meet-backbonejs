# ##Adding Actions to a View
#
# Our models have been pretty lifeless so far. We'll attach some actions to 
# our `Item`s for some dynamic goodness. Take a look at 
# [the implementation](../) before getting started.

#
jQuery ->
  
  class Item extends Backbone.Model
    
    defaults:
      part1: 'Hello'
      part2: 'Backbone'
  
  
  class List extends Backbone.Collection
    
    model: Item
  
  
  class ItemView extends Backbone.View
    
    tagName: 'li'
    
    # `initialize()` 
    # binds [`change`](http://documentcloud.github.com/backbone/#Model-change) 
    # and [`remove`](http://documentcloud.github.com/backbone/#Collection-remove) 
    # to `@render` and `@unrender`, respectively.
    initialize: ->
      _.bindAll @
      
      @model.bind 'change', @render
      @model.bind 'remove', @unrender
    
    # `render()` now includes two extra `span`s for swapping and deleting 
    # an item.
    render: =>
      $(@el).html """
        <span>#{@model.get 'part1'} #{@model.get 'part2'}!</span>
        <span class="swap">swap</span>
        <span class="delete">delete</span>
      """
      @
    
    # `unrender()` removes the calling list item from the DOM. This uses 
    # [jQuery's `remove()` method](http://api.jquery.com/remove/).
    unrender: =>
      $(@el).remove()
    
    # `swap()` interchanges an `Item`'s attributes. The [`set()` model 
    # function](http://documentcloud.github.com/backbone/#Model-set) triggers 
    # the `change` event.
    swap: ->
      @model.set
        part1: @model.get 'part2'
        part2: @model.get 'part1'
    
    
    # `remove()` calls the model's 
    # [`destroy()`](http://documentcloud.github.com/backbone/#Model-destroy) 
    # method, removing the model from its collection. `destroy()` would 
    # normally delete the record from its persistent storage, but we'll 
    # override this in `Backbone.sync` below.
    remove: -> @model.destroy()
    
    # `ItemView`s now respond to two click actions for each `Item`.
    events:
      'click .swap': 'swap'
      'click .delete': 'remove'
  
  
  # We no longer need to modify the `ListView` because `swap` and `delete` are
  # called on each `Item`.
  class ListView extends Backbone.View
    
    el: $ 'body'
    
    initialize: ->
      _.bindAll @
      
      @collection = new List
      @collection.bind 'add', @appendItem
      
      @counter = 0
      @render()
    
    render: ->
      $(@el).append '<button>Add Item List</button>'
      $(@el).append '<ul></ul>'
    
    addItem: ->
      @counter++
      item = new Item
      item.set part2: "#{item.get 'part2'} #{@counter}"
      @collection.add item
    
    appendItem: (item) ->
      item_view = new ItemView model: item
      $('ul').append item_view.render().el
    
    events: 'click button': 'addItem'
  
  
  # We'll override 
  # [`Backbone.sync`](http://documentcloud.github.com/backbone/#Sync) since 
  # we're not making any calls to the server when we change our model. 
  Backbone.sync = (method, model, success, error) ->
    
    # Perform a NOOP when we successfully change our model. In our example,
    # this will happen when we remove each Item view.
    success()
  
  
  list_view = new ListView
