#= require angular
#= require angular-resource
#= require angular-route
#= require angular-loading-bar
#= require angular-messages
#= require angular-strap/angular-strap.js
#= require angular-strap/angular-strap.tpl.js

app = angular.module("musicApp",
                    [
                     'angular-loading-bar'
                     'ngResource'
                     'ngRoute'
                     'ngMessages'
                     'mgcrea.ngStrap'
                    ])

app.config ($httpProvider) ->
  authToken = $("meta[name='csrf-token']").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

app.config ($routeProvider, $locationProvider) ->
  #$locationProvider.html5Mode true
  $routeProvider
    .when('/',
          {
            redirectTo: '/hottt'
          })
    .when('/hottt',
          {
            templateUrl: '/api/v1/playlists/playlist_embed.html',
            controller: 'HotttPlaylistController'
          })
    .when('/top-tracks',
          {
            templateUrl: '/api/v1/playlists/top_tracks.html',
            controller: 'TopTracksPlaylistController'
          })
    .otherwise({
      redirectTo: '/hottt'
    })

app.factory "Playlist", ($resource) ->
  $resource('/api/v1/playlists/:id.json', {id: '@id'})

app.factory "PlaylistService", ($http) ->
  hottt: ->
    $http.get('/api/v1/playlist/hottt')
      .success (response) ->
        response.data
  topTracks: (options) ->
    console.log(options)
    url = '/api/v1/playlist/top_tracks?'
    _.forIn options, (value, key) ->
      url += "&" + key + "=" + value
    $http.get(url) #FIXME send params (routeParams?)
      .success (response) ->
        response.data

app.factory "SpotifyService", ->
  generateSpotifyEmbedUrl: (spotifyIds, playlistName) ->
    baseUrl = "https://embed.spotify.com/?uri=spotify:trackset:"
    baseUrl + playlistName + ':' + spotifyIds

app.factory "LastfmService", ($http) ->
  getUserByUsername: (username) ->
    $http.get '/api/v1/lastfm/user', { params: { username: username } }

app.factory "DataModel", ->
  data = {
    data: {
      lastfmUsername: 'echowarpt' #fixme, get from rails
      periods: [
        {name: 'last week', period: '7day'}
        {name: 'last month', period: '1month'}
        {name: 'last 3 months', period: '3month'}
        {name: 'last 6 months', period: '6month'}
        {name: 'last 12 months', period: '12month'}
      ]
    }
  }
  #@data.period = data.data.periods[0]
  #{ data }
  data.data.period = data.data.periods[0]
  data

app.controller "HotttPlaylistController", ($scope, $routeParams, $sce, PlaylistService, SpotifyService) ->
  window.HOTTT = $scope
  $scope.data = {}
  $scope.data.name = 'Hottt Tracks'
  PlaylistService.hottt().then (response) ->
    spotifyEmbedUrl = SpotifyService.generateSpotifyEmbedUrl(response.data)
    $scope.data.spotifyEmbedUrl = $sce.trustAsResourceUrl(spotifyEmbedUrl)
    $scope.data.templateUrl = '/api/v1/playlists/top_tracks.html'


app.controller "TopTracksPlaylistController", ($scope, $routeParams, $sce, DataModel, PlaylistService, SpotifyService) ->
  window.TOPTRACKS = $scope
  $scope.data = DataModel.data
  $scope.master = $scope.data
  $scope.data.name = 'Top Tracks' # fixme: ... for DATE RANGE'
  $scope.data.templateUrl = '/api/v1/playlists/playlist_embed.html'

  $scope.getTopTracks = (options) ->
    PlaylistService.topTracks(options).then (promise) ->
      spotifyEmbedUrl = SpotifyService.generateSpotifyEmbedUrl(promise.data)
      $scope.data.spotifyEmbedUrl = $sce.trustAsResourceUrl(spotifyEmbedUrl)
  $scope.getTopTracks($routeParams)

  $scope.submit = (form) ->
    # If form is invalid, return and let AngularJS show validation errors.
    return unless form.$valid
    
    # refresh the top tracks with given params
    $scope.getTopTracks({period: $scope.data.period.period, user: $scope.data.lastfmUsername})

  $scope.reset = ->
    $scope.data = $scope.master

app.directive 'userExistsValidator', ($q, LastfmService) ->
  require : 'ngModel',
  link : (scope, element, attrs, ngModel) ->
    ngModel.$asyncValidators.usernameAvailable = (username) ->
      deferred = $q.defer()

      LastfmService.getUserByUsername(username)
        .then (response) ->
          if response.data.error
            deferred.reject()
          else
            deferred.resolve()
        , (response) -> # http status == error status
          deferred.reject()

      deferred.promise

app.directive 'jaSpotifyEmbed', ->
  scope:
    spotifyEmbedUrl: '='
  template:
    """
    <iframe id='spotify-playlist' allowtransparency='true' frameborder='0' width='500' height='500' src="{{spotifyEmbedUrl}}" }></iframe>
    """
