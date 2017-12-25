# @abstract_class

class MoviesJS.Lib.UIComponent
  class MissingContainerError extends Error

  class UIDelegat
    constructor: (@$itemsContainer, @selector) ->

    on: ->
      eventName = arguments[0]

      if arguments.length == 2
        eventsTargetSelector = "#{@selector}"
        callback = arguments[1]

      else if arguments.length == 3
        childElementSelector = arguments[1]
        eventsTargetSelector = "#{@selector} #{childElementSelector}"
        callback = arguments[2]

      @$itemsContainer.on eventName, eventsTargetSelector, (e) =>
        target = e.target
        $containerItem = @getItemFor(target)
        callback
          originalEvent: e
          target: e.target
          currentTarget: e.currentTarget
          $item: $containerItem
          itemData: $containerItem.get(0).dataset

    getItemFor: (domNode) ->
      $(domNode).closest(@selector)

  defaultContainerID: undefined

  constructor: (@params = {}) ->
    @eventsRegistry = {}
    @_findContainer(@params)
    @_initBasicFunctionality()

  _dispatchEvent: (eventName, data) ->
    if @eventsRegistry[eventName]?
      for eventCallback in @eventsRegistry[eventName]
        eventCallback(data)

  _createDelegat: (selector) ->
    new UIDelegat(@$container, selector)

  on: (eventName, func) =>
    unless @eventsRegistry[eventName]?
      @eventsRegistry[eventName] = []
    @eventsRegistry[eventName].push(func)

  _initVariables: ->
    false

  _initUI: ->
    false

  _initPlugins: ->
    false

  _initEventListeners: ->
    false

  _initBasicFunctionality: ->
    if @$container.length
      @_initVariables()
      @_initUI()
      @_initPlugins()
      @_initEventListeners()

  _findContainer: (params) ->
    if params.container?
      @$container = params.container
    else
      if params.containerID?
        @containerID = params.containerID
      else if @defaultContainerID?
        @containerID = @defaultContainerID

      if @containerID?
        @$container = $(@containerID)
      else
        throw new MissingContainerError('Container or containerID is unspecified')

  reInitComponent: (params) ->
    @_findContainer(params)
    @_initBasicFunctionality()

