'use strict'

angular.module('gitPrettyStats')
  .factory 'Repository', ($http) ->
    repository = {}

    repository.all = ->
      $http(
        method: 'GET'
        url: base_url + '/repository/'
      )

    repository.get = (name) ->
      $http(
        method: 'GET'
        url: base_url + '/repository/' + name
      )

    repository
