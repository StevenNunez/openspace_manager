import Ember from 'ember';

export default Ember.Route.extend({
  actions: {
    addEvent: function(){
      var event = this.store.createRecord('event', {
        name: this.controller.get('name')
      });
      event.save().then(() => {
        this.controller.set('name', "");
        this.transitionTo('events.event', event.get('slug'));
      });
    }
  }
});
