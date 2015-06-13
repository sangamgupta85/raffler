class Raffler.Views.EntriesIndex extends Backbone.View

  template: JST['entries/index']

  events:
  	"submit #new_entry": "createEntry"

  initialize: ->
    @collection.on('sync', @render, this)

  render: ->
  	$(@el).html(@template(entries: @collection))
  	this

  createEntry: (event) ->
  	event.preventDefault()
    #attributes = name: $("#new_entry_name").val()
  	@collection.create name: $("#new_entry_name").val(),
      wait: true
      error: @handleError

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
