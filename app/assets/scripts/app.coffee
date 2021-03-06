'use strict'

angular.module('gitPrettyStats', [
  'ui.router',
  'snap',
  'chieffancypants.loadingBar'
])
  .run ($rootScope, $state, $stateParams, snapRemote) ->
    $rootScope.$state = $state
    $rootScope.$stateParams = $stateParams

    $rootScope.$on '$locationChangeStart', ->
      snapRemote.close()

  .config ($stateProvider, $urlRouterProvider, snapRemoteProvider) ->
    snapRemoteProvider.globalOptions.touchToDrag = false

    $urlRouterProvider.otherwise "/repositories"

    $stateProvider
      .state 'repositories',
        url: '/repositories'
        templateUrl: 'views/main.html'
        controller: 'RepositoriesController'
        resolve:
          repositories: (Repository) ->
            Repository.all()
      .state 'repository',
        parent: 'repositories'
        url: '/:name'
        templateUrl: 'views/repository.html'
        controller: 'RepositoryController'
        resolve:
          repo: ($stateParams, Repository) ->
            Repository.get($stateParams.name)
