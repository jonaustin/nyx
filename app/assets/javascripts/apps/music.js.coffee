#= require angular
#= require angular-resource
#= require angular-route
#= require angular-loading-bar
#= require angular-strap/angular-strap.js
#= require angular-strap/angular-strap.tpl.js

app = angular.module("musicApp",
                    [
                     'angular-loading-bar'
                     'ngResource'
                     'ngRoute'
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
            templateUrl: '/api/playlists/playlist_embed.html',
            controller: 'HotttPlaylistController'
          })
    .when('/top-tracks',
          {
            templateUrl: '/api/playlists/top_tracks.html',
            controller: 'TopTracksPlaylistController'
          })
    .otherwise({
      redirectTo: '/hottt'
    })

app.factory "Playlist", ($resource) ->
  $resource('/api/playlists/:id.json', {id: '@id'})

app.factory "PlaylistService", ($http) ->
    hottt: ->
      $http.get('/api/playlist/hottt')
        .success (response) ->
          response.data
    topTracks: (options) ->
      console.log(options)
      url = '/api/playlist/top_tracks?'
      _.forIn options, (value, key) ->
        url += "&" + key + "=" + value
      $http.get(url) #FIXME send params (routeParams?)
        .success (response) ->
          response.data

app.factory "SpotifyService", ->
  {
    generateSpotifyEmbedUrl: (spotifyIds, playlistName) ->
      baseUrl = "https://embed.spotify.com/?uri=spotify:trackset:"
      baseUrl + playlistName + ':' + spotifyIds
  }

app.factory "DataModel", ->
  {
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


app.controller "HotttPlaylistController", ($scope, $routeParams, $sce, PlaylistService, SpotifyService) ->
  window.HOTTT = $scope
  $scope.data = {}
  $scope.data.name = 'Hottt Tracks'
  PlaylistService.hottt().then (response) ->
    spotifyEmbedUrl = SpotifyService.generateSpotifyEmbedUrl(response.data)
    $scope.data.spotifyEmbedUrl = $sce.trustAsResourceUrl(spotifyEmbedUrl)
    $scope.data.templateUrl = '/api/playlists/top_tracks.html'


app.controller "TopTracksPlaylistController", ($scope, $routeParams, $sce, DataModel, PlaylistService, SpotifyService) ->
  window.TOPTRACKS = $scope
  $scope.data = DataModel.data
  $scope.data.name = 'Top Tracks' # fixme: ... for DATE RANGE'
  $scope.data.templateUrl = '/api/playlists/playlist_embed.html'

  console.log($routeParams)
  PlaylistService.topTracks($routeParams).then (response) ->
    spotifyEmbedUrl = SpotifyService.generateSpotifyEmbedUrl(response.data)
    $scope.data.spotifyEmbedUrl = $sce.trustAsResourceUrl(spotifyEmbedUrl)

  $scope.submit = (form) ->
    # Trigger validation flag.
    $scope.submitted = true

    # If form is invalid, return and let AngularJS show validation errors.
    return unless form.$valid

    # ....
