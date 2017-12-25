class MoviesJS.Lib.ApiClient
  @baseURL: ''
  @responseDataType: 'json'
  @cache: false

  baseURL: ''
  responseDataType: 'json'
  cache: false

  constructor: (params = {}) ->
    @baseURL = params.baseURL || ''
    @defaultData = params.dafaultData || {}

  @_buildData: (data, method) ->
    if method == 'POST' || method == 'PATCH'
      JSON.stringify(data)
    else
      data

  @static_request: (method, url, data = {}) ->
    $.ajax
      method: method
      url: @baseURL + url
      cache: @cache
      dataType: @responseDataType
      contentType: 'application/json'
      data: @_buildData(data, method)

  @get: (url, params) ->
    @static_request('GET', url, params)

  @post: (url, data) ->
    @static_request('POST', url, data)

  @patch: (url, data) ->
    @static_request('PATCH', url, data)

  @delete: (url) ->
    @static_request('DELETE', url)

  @submitForm: (method, url, data = {}) ->
    $.ajax
      method: method
      url: @baseURL + url
      dataType: @responseDataType
      data: data

  request: (method, url, data = {}) ->
    ajaxData = $.extend({}, @defaultData, data)
    $.ajax
      method: method
      url: @baseURL + url
      cache: @cache
      dataType: @responseDataType
      contentType: 'application/json'
      data: MoviesJS.Lib.ApiClient._buildData(ajaxData, method)

  get: (url, params) ->
    @request('GET', url, params)

  post: (url, data) ->
    @request('POST', url, data)

  patch: (url, data) ->
    @request('PATCH', url, data)

  delete: (url) ->
    @request('DELETE', url)
