Template.trello.lists = -> Lists.find()
Template.list.items = -> Items.find listId:@_id

Template.list.events =
  'dropped item-list': (e, template, ui) ->
    console.log 'item-dropped', e.originalEvent.detail
    {list,data} = e.originalEvent.detail
    Items.update {_id: data}, {"$set": {listId: list}}
  
  'submit form': (e, template) ->
    e.preventDefault()
    text = template.find('.newInput').value
    Items.insert {text: text, listId:@_id}
    Meteor.defer -> template.find('.newInput').value = ''