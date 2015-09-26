import Ember from 'ember';

export default Ember.Route.extend({
  model(params){
    var event = this.modelFor('events.event');
    return event.get('tracks'); // leads to less requests
    // Requests /tracks?event_id=:id to work, If you can sideload, you're better off
    // return this.store.query('track', {event_id: event.get('id')});
  },
  setupControllder(){
    var event = this.modelFor('events.event');
    this.contoller.set('event', event);
  }
});
