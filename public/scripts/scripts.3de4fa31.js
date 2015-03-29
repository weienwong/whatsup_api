"use strict";angular.module("cLifeAngularApp",["ngAnimate","ngCookies","EventsFactory","ngResource","ngRoute","ngSanitize","ngTouch"]).config(["$routeProvider",function(a){a.when("/",{templateUrl:"views/main.html",controller:"MainCtrl"}).when("/about",{templateUrl:"views/about.html",controller:"AboutCtrl"}).when("/event",{templateUrl:"views/event.html",controller:"EventCtrl"}).otherwise({redirectTo:"/"})}]),angular.module("cLifeAngularApp").controller("MainCtrl",["eventsFactory","$scope",function(a,b){a.getAllEvents().success(function(a){b.allEvents=a}),a.getEventCategories().success(function(a){b.event_categories=a;var c=[];for(i in a)c.push({label:a[i].category_name,value:a[i].id});console.log(c),b.event_categories_options=c}),b.category_id,b.showEventId=function(c){a.showEvent(c).success(function(a){b.eventData=a})}}]),angular.module("cLifeAngularApp").controller("AboutCtrl",["$scope",function(a){a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}]);var eventsFactory=angular.module("EventsFactory",[]);eventsFactory.factory("eventsFactory",["$http",function(a){var b="/events";return eventsFactory.getAllEvents=function(){return a.get(b)},eventsFactory.showEvent=function(c){return a.get(b+"/"+c)},eventsFactory.getEventByCategory=function(c){return a.get(b+"/event_category/"+c)},eventsFactory.getEventCategories=function(){return a.get("/event_categories")},eventsFactory}]);