Template.trello.lists = -> Lists.find()
Template.list.items = -> Items.find listId:@_id

Template.header.events =
  'submit': (e, template) ->
    e.preventDefault()
    Lists.insert name: template.find('input').value
    Meteor.defer -> template.find('input').value = ''

Template.list.events =
  'dropped item-list': (e, template) ->
    console.log 'item-dropped', e.originalEvent.detail
    {list,data} = e.originalEvent.detail
    Items.update {_id: data}, {"$set": {listId: list}}
  
  'submit .newItem': (e, template) ->
    e.preventDefault()
    text = template.find('input').value
    Items.insert {text: text, listId:@_id}
    Meteor.defer -> template.find('input').value = ''
    
  'click .deleteItem': ->
    Items.remove _id: @_id
    
  'click .deleteList': ->
    Lists.remove _id: @_id