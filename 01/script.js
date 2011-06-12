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
    var ListView, list_view;
    ListView = (function() {
      __extends(ListView, Backbone.View);
      function ListView() {
        ListView.__super__.constructor.apply(this, arguments);
      }
      ListView.prototype.el = $('body');
      ListView.prototype.initialize = function() {
        _.bindAll(this);
        return this.render();
      };
      ListView.prototype.render = function() {
        return $(this.el).append('<ul><li>Hello, Backbone!</li></ul>');
      };
      return ListView;
    })();
    return list_view = new ListView;
  });
}).call(this);
