class App.View extends Backbone.View
  initialize: (options) ->
    @template ||= options.template
    @presenter ||= options.presenter
    @selectionModel = options.selectionModel

  destroy: ->
    @hide()
    @unbind()
    @remove
    @

  events: ->
    {}

  hide: ->
    @$el.hide()
    @

  html: (html) ->
    @$el.html html
    @

  render: ->
    @_rendered = true
    if @template?
      @html @renderTemplate(@template, @renderContext(), @renderPartials())
    @

  renderContext: ->
    if @presenter?
      @presenter.apply @, [@model]
    else if @model?
      @model.toJSON()
    else
      {}

  renderPartials: ->
    {}

  renderTemplate: (template, context, partials) ->
    @_template(template).render context, partials

  show: ->
    @render() unless @_rendered?
    @$el.show()
    @

  unbind: ->
    @undelegateEvents()
    @model.off(null, null, null) if @model
    @collection.off(null, null, null) if @collection
    # TODO
    # undo other bindings (for example to models or jQuery)

  _template: (template) ->
    HoganTemplates[template]
