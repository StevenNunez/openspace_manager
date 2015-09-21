import Ember from 'ember';

export default Ember.Route.extend({
  actions: {
    addEvent: function(){
      var event = this.store.createRecord('event', {
        name: this.controller.get('name'),
        slug_name: this.controller.get('slug-name')
      });
      event.save().then(() => {
        this.controller.set('name', "");
        this.transitionTo('events.event', event.get('slug_name'));
      })
    },
    generateSlug: function(event){
      var slug = event.toLowerCase().replace(/\s+/g, "-");
      this.controller.set('slug-name', slug);
      }
    }
});
