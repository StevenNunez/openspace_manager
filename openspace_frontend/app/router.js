import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('events', function(){
    // this.route('event', {path: "/:event-slug"});
    this.route('new');
    this.route('event', {path: ":event_slug"});
  });
});

export default Router;
