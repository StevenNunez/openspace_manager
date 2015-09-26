import Ember from 'ember';

export default Ember.Route.extend({
  model(params){
    return this.store.find('event', params.event_slug);
  },
  serialize(){
    slug: model.get("slug");
  }
});
