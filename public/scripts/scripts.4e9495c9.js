"use strict";angular.module("cLifeAngularApp",["ngAnimate","ngCookies","EventsFactory","ngResource","ngRoute","ngSanitize","ngTouch"]).config(["$routeProvider",function(a){a.when("/",{templateUrl:"views/main.html",controller:"MainCtrl"}).when("/about",{templateUrl:"views/about.html",controller:"AboutCtrl"}).otherwise({redirectTo:"/"})}]),angular.module("cLifeAngularApp").controller("MainCtrl",["eventsFactory","$scope","$location","$anchorScroll","$rootScope",function(a,b,c,d,e){e.eventName="",e.category_id=0,e.time="today",e.time_to_display="today",a.getEventByTimeAndCategory(b.time,b.category_id).success(function(a){b.allEvents=a}),a.getEventCategories().success(function(a){b.event_categories=a;var c,d=[];d.push({label:"All Events",value:0});for(c in a)d.push({label:a[c].category_name,value:a[c].id});b.event_categories_options=d,b.selected_event_category=d[0]}),a.getUniversities().success(function(a){b.universities=a;var c,d=[];d.push({label:"All schools",value:0});for(c in a)d.push({label:a[c].name,value:a[c].id});b.universities_options=d,b.selected_university=d[1]}),b.getEventsByCategoryId=function(c){e.category_id=c,a.getEventByTimeAndCategory(b.time,b.category_id).success(function(a){b.allEvents=a})},b.showToday=function(){a.getEventByTimeAndCategory("today",b.category_id).success(function(a){b.allEvents=a}),e.time="today",e.time_to_display="today",e.eventName=""},b.showThisWeek=function(){a.getEventByTimeAndCategory("week",b.category_id).success(function(a){b.allEvents=a}),e.time="week",e.time_to_display="this week",e.eventName=""},b.showThisMonth=function(){a.getEventByTimeAndCategory("month",b.category_id).success(function(a){b.allEvents=a}),e.time="month",e.time_to_display="this month",e.eventName=""},b.showLater=function(){a.getEventByTimeAndCategory("later",b.category_id).success(function(a){b.allEvents=a}),e.time="later",e.time_to_display="later",e.eventName=""},e.goToTop=function(){console.log(c.hash("top")),console.log(e.time),d(),console.log(e.time)}}]),angular.module("cLifeAngularApp").controller("AboutCtrl",["$scope",function(a){a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}]);var eventsFactory=angular.module("EventsFactory",[]);eventsFactory.factory("eventsFactory",["$http",function(a){var b="/events";return eventsFactory.getEventByTimeAndCategory=function(c,d){return a.get(b+"?when="+c+"&category_id="+d)},eventsFactory.getEventByCategory=function(c){return a.get(b+"/event_category/"+c)},eventsFactory.getEventCategories=function(){return a.get("/event_categories")},eventsFactory.getEventsByCategoryId=function(b){return a.get("/event_category/"+b)},eventsFactory.getUniversities=function(){return a.get("/universities")},eventsFactory}]);