import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('events', function(){
    this.route('new');
    this.route('event', {path: ":event_slug"}, function(){
      this.route('tracks', function() {
        this.route('new');
        this.route('track', {path: ":track_slug"});
      });
    });
  });
});

export default Router;
