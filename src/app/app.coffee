app = angular.module 'ecommerce', ['ui.bootstrap', 'ngRoute', 'productsController']

app.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $routeProvider
    .when '/', {
      templateUrl: 'partials/products',
      controller: 'ProductsCtrl'
    }
    .otherwise {
      redirectTo: '/'
    }
  $locationProvider.html5Mode {
    enable:true,
    requireBase: false
  }
]
