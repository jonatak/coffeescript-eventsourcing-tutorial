productsController = angular.module 'productsController', []

productsController.controller 'ProductsCtrl', ['$scope', '$http', ($scope, $http) ->

  loadBank = () ->
    $http
      .get '/bank'
      .success (data, status, headers, config) -> $scope.bank = data.bank


  loadBasket = () ->
    $http
      .get '/basket'
      .success (data, status, headers, config) -> $scope.basket = data


  $scope.addToBasket = (productId) ->
    $http
      .post '/basket/add', {'productId': productId}
      .then (response) ->
        loadBasket()
        $scope.basketTab = true
      , (response) -> return

  $http
    .get '/products'
    .success (data, status, headers, config) -> $scope.products = data.products


  $scope.discardBasket = () ->
    $http
      .post 'basket/discard', {}
      .success (data, status, headers, config) -> loadBasket()


  $scope.validateBasket = () ->
    $http
      .post 'basket/validate', {}
      .success (data, status, headers, config) -> loadBasket()


  $scope.reloadBank = () ->
    $http
      .post 'basket/reload', {}
      .success (data, status, headers, config) -> console.log "state reload"


  $scope.basketTab = false
  timer = setInterval (() -> $scope.$apply loadBank), 1000
  loadBasket()
  loadBank()
]


productsController.directive 'mainElem', () ->
  {
    templateUrl: 'partials/main',
    replace: true,
    controller: 'ProductsCtrl',
    controllerAs: 'ctrl',
    bindToController: true
  }


productsController.directive 'productList', () ->
  {
    templateUrl: 'partials/products',
    replace: true,
    controller: 'ProductsCtrl',
    controllerAs: 'ctrl',
    bindToController: true
  }


productsController.directive 'basketList', () ->
  {
    templateUrl: 'partials/basket',
    replace: true,
    controller: 'ProductsCtrl',
    controllerAs: 'ctrl',
    bindToController: true
  }
