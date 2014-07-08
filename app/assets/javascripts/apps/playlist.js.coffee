#= require angular
#= require angular-resource
#= require angular-route
#= require angular-loading-bar
#= require angular-ui-bootstrap-bower
# require angular-ui-select2/select2

app = angular.module("playlistApp",
                    [
                     'angular-loading-bar'
                     'ngResource'
                     'ngRoute'
                     'ui.bootstrap'
                    ])

app.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

app.config ($routeProvider, $locationProvider) ->
  #$locationProvider.html5Mode true
  $routeProvider.when '/', templateUrl: '/api/playlists/hottt.html', controller: 'PlaylistController' 
  #$routeProvider.when '/', redirectTo: '/hottt
  #$routeProvider.when '/hottt', templateUrl: '/playlists/hottt.html', controller: 'PlaylistController'

app.factory("Playlist", ($resource) ->
  $resource('/api/playlists/:id.json', {id: '@id'})
)

app.factory("PlaylistService", ($http, DataModel) ->
  {
    hottt: ->
      $http.get('/api/playlist/hottt')
        .success (data) ->
          DataModel.data.spotify_ids = data.data
  }
)

app.factory("DataModel", ->
  {
    data: {
      name: ''
      #tracks: []
      spotify_ids: []
    }
  }

)

app.controller("PlaylistController", ($scope, $sce, DataModel, PlaylistService) ->
  window.PLAYLIST = $scope
  $scope.data = DataModel.data
  PlaylistService.hottt().then (data) ->
    $scope.data.spotify_ids = data.data
    $scope.data.spotify_embed_url = "https://embed.spotify.com/?uri=spotify:trackset:" + $scope.data.name + ':' + $scope.data.spotify_ids
    $scope.data.spotify_embed_url = $sce.trustAsResourceUrl($scope.data.spotify_embed_url)

)
