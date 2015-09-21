import Ember from 'ember';

export default Ember.Route.extend({
  model: function(params){
    return {
      eventName: params.event_slug
    }
  }
});
