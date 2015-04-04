"use strict";angular.module("cLifeAngularApp",["ngAnimate","ngCookies","EventsFactory","ngResource","ngRoute","ngSanitize","ngTouch"]).config(["$routeProvider",function(a){a.when("/",{templateUrl:"views/main.html",controller:"MainCtrl"}).when("/about",{templateUrl:"views/about.html",controller:"AboutCtrl"}).when("/contact",{templateUrl:"views/contact.html",controller:"ContactCtrl"}).otherwise({redirectTo:"/"})}]),angular.module("cLifeAngularApp").controller("MainCtrl",["eventsFactory","$scope",function(a,b){b.show_today=1,b.show_this_week=0,b.show_this_month=0,b.show_later=0,b.eventName="",b.category_id=0,a.getEventByTimeAndCategory("today",b.category_id).success(function(a){b.allEvents=a}),a.getEventCategories().success(function(a){b.event_categories=a;var c,d=[];d.push({label:"All Events",value:0});for(c in a)d.push({label:a[c].category_name,value:a[c].id});b.event_categories_options=d,b.selected_event_category=d[0]}),a.getUniversities().success(function(a){b.universities=a;var c,d=[];d.push({label:"All schools",value:0});for(c in a)d.push({label:a[c].name,value:a[c].id});b.universities_options=d,b.selected_university=d[0]}),b.getEventsByCategoryId=function(a){b.category_id=a},b.showToday=function(){b.show_today=1,b.show_this_week=0,b.show_this_month=0,b.show_later=0,a.getEventByTimeAndCategory("today",b.category_id).success(function(a){b.allEvents=a}),b.eventName=""},b.showThisWeek=function(){b.show_today=0,b.show_this_week=1,b.show_this_month=0,b.show_later=0,a.getEventByTimeAndCategory("week",b.category_id),b.eventName=""},b.showThisMonth=function(){b.show_today=0,b.show_this_week=0,b.show_this_month=1,b.show_later=0,a.getEventByTimeAndCategory("month",b.category_id),b.eventName=""},b.showLater=function(){b.show_today=0,b.show_this_week=0,b.show_this_month=0,b.show_later=1,a.getEventByTimeAndCategory("later",b.category_id),b.eventName=""}}]),angular.module("cLifeAngularApp").controller("AboutCtrl",["$scope",function(a){a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}]);var eventsFactory=angular.module("EventsFactory",[]);eventsFactory.factory("eventsFactory",["$http",function(a){var b="/events";return eventsFactory.getEventByTimeAndCategory=function(c,d){return a.get(b+"?when="+c+"&category_id="+d)},eventsFactory.getEventByCategory=function(c){return a.get(b+"/event_category/"+c)},eventsFactory.getEventCategories=function(){return a.get("/event_categories")},eventsFactory.getEventsByCategoryId=function(b){return a.get("/event_category/"+b)},eventsFactory.getUniversities=function(){return a.get("/universities")},eventsFactory}]);