import Ember from 'ember';

export default Ember.Route.extend({
  actions: {
    addTrack: function(){
      var event = this.modelFor('events.event');
      var track = this.store.createRecord('track', {
        name: this.controller.get('name'),
        event: event
      })
      track.save().then(() => {
        this.controller.set('name', name)
        this.transitionTo('events.event.tracks.track', event.get('slug'), track.get('slug'));
      })
    }
  }
});
