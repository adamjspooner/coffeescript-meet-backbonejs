(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  jQuery(function() {
    var Item, List, ListView, list_view;
    Item = (function() {
      __extends(Item, Backbone.Model);
      function Item() {
        Item.__super__.constructor.apply(this, arguments);
      }
      Item.prototype.defaults = {
        part1: 'Hello',
        part2: 'Backbone'
      };
      return Item;
    })();
    List = (function() {
      __extends(List, Backbone.Collection);
      function List() {
        List.__super__.constructor.apply(this, arguments);
      }
      List.prototype.model = Item;
      return List;
    })();
    ListView = (function() {
      __extends(ListView, Backbone.View);
      function ListView() {
        ListView.__super__.constructor.apply(this, arguments);
      }
      ListView.prototype.el = $('body');
      ListView.prototype.initialize = function() {
        _.bindAll(this);
        this.collection = new List;
        this.collection.bind('add', this.appendItem);
        this.counter = 0;
        return this.render();
      };
      ListView.prototype.render = function() {
        $(this.el).append('<button>Add List Item</button>');
        return $(this.el).append('<ul></ul>');
      };
      ListView.prototype.addItem = function() {
        var item;
        this.counter++;
        item = new Item;
        item.set({
          part2: "" + (item.get('part2')) + " " + this.counter
        });
        return this.collection.add(item);
      };
      ListView.prototype.appendItem = function(item) {
        return $('ul').append("<li>" + (item.get('part1')) + " " + (item.get('part2')) + "!</li>");
      };
      ListView.prototype.events = {
        'click button': 'addItem'
      };
      return ListView;
    })();
    return list_view = new ListView;
  });
}).call(this);
