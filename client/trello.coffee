Template.trello.lists = -> Lists.find()
Template.list.items = -> Items.find listId:@_id

Template.trello.foo = -> Lists.findOne {}
Template.trello.events =
  'submit .myForm': (e) ->
    e.stopPropagation()
    e.preventDefault()
    console.log 'WAAAAAA'

Template.list.events =
  'dropped item-list': (e, template, ui) ->
    console.log 'item-dropped', e.originalEvent.detail
    {list,data} = e.originalEvent.detail
    Items.update {_id: data}, {"$set": {listId: list}}
  
  'submit .newItem': (e, template) ->
    e.preventDefault()
    text = template.find('input').value
    Items.insert {text: text, listId:@_id}
    Meteor.defer -> template.find('input').value = ''
    
  'click .deleteItem': (e, template) ->
    Items.remove _id: @_id
    