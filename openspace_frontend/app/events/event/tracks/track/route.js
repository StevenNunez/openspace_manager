import Ember from 'ember';

export default Ember.Route.extend({
  model(params){
    var event = this.modelFor('events.event');
    // less requests... but I want to fetch more info at this point.
    // return event.get('tracks').findBy('slug', params.track_slug)
    return this.store.find('track', params.track_slug);
  },
  serialize(){
    slug: model.get("slug");
  }
});
