"use strict";angular.module("cLifeAngularApp",["ngAnimate","ngCookies","EventsFactory","ngResource","ngRoute","ngSanitize","ngTouch","angular-spinkit"]).config(["$routeProvider",function(a){a.when("/",{templateUrl:"views/main.html",controller:"MainCtrl"}).when("/about",{templateUrl:"views/about.html",controller:"AboutCtrl"}).otherwise({redirectTo:"/"})}]),angular.module("cLifeAngularApp").controller("MainCtrl",["eventsFactory","$scope","$location","$anchorScroll","$rootScope",function(a,b,c,d,e){c.hash("top"),a.getUniversities().success(function(a){b.universities=a;var c,d=[];d.push({label:"All schools",value:0});for(c in a)d.push({label:a[c].name,value:a[c].id});b.universities_options=d,b.selected_university=d[1]});var f=[];f.push({value:"today",label:"Today"}),f.push({value:"week",label:"This Week"}),f.push({value:"month",label:"This Month"}),f.push({value:"later",label:"Next Month"}),b.timeDropdown=f,b.selectedTime=f[1],b.timeToDisplay=b.selectedTime.label,b.timeValue=b.selectedTime.value,b.showJobInfoSession=function(c,d){a.getJobInfoSession(c,d).success(function(a){b.jobInfoSessionData=a})},b.facultySearch=function(a){b.facultyToDisplay=a,b.showJobInfoSession(b.timeValue,b.facultyToDisplay.faculty_short)},b.showOneJobInfoSession=function(c){a.getOneJobInfoSession(c).success(function(a){b.moreJobInfoSessionData=a})},a.getEventCategories().success(function(c){b.event_categories=c;var d=[];for(var e in c)d.push({label:c[e].category_name,value:c[e].id});d.push({label:"All Events",value:0}),b.event_categories_options=d,b.selectedCategory=d[0],b.categoryValue=b.selectedCategory.value,b.categoryToDisplay=b.selectedCategory.label,27==b.categoryValue?a.getFaculties().success(function(a){var c=[];for(var d in a)c.push(a[d]);b.facultiesDropdown=c,b.facultyToDisplay=c[0],b.facultyDisplayName=b.facultyToDisplay.faculty,b.facultyShortName=b.facultyToDisplay.faculty_short,b.showJobInfoSession(b.timeValue,"")}):a.getEventByTimeAndCategory(b.timeValue,b.categoryValue).success(function(a){b.allEvents=a})}),b.selectEventCategory=function(c){b.selectedCategory=c,b.categoryToDisplay=b.selectedCategory.label,b.categoryValue=b.selectedCategory.value,27==b.categoryValue?b.showJobInfoSession(b.timeValue,""):a.getEventByTimeAndCategory(b.timeValue,b.categoryValue).success(function(a){b.allEvents=a})},b.selectTime=function(c){b.selectedTime=c,b.timeToDisplay=b.selectedTime.label,b.timeValue=b.selectedTime.value,27==b.categoryValue?b.showJobInfoSession(b.timeValue,b.facultyToDisplay.faculty_short):a.getEventByTimeAndCategory(b.timeValue,b.categoryValue).success(function(a){b.allEvents=a})},e.goToTop=function(){console.log("Go to top is called!"),"top"!==c.hash&&c.hash("top"),d.yOffset=50,d()}}]),angular.module("cLifeAngularApp").controller("AboutCtrl",["$scope",function(a){a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}]);var eventsFactory=angular.module("EventsFactory",[]);eventsFactory.factory("eventsFactory",["$http",function(a){var b="/events";return eventsFactory.getEventByTimeAndCategory=function(c,d){return a.get(b+"?when="+c+"&category_id="+d)},eventsFactory.getEventByCategory=function(c){return a.get(b+"/event_category/"+c)},eventsFactory.getJobInfoSession=function(b,c){return a.get("/job_info_sessions?time="+b+"&faculty="+c)},eventsFactory.getOneJobInfoSession=function(b){return a.get("/job_info_sessions/"+b)},eventsFactory.getEventCategories=function(){return a.get("/event_categories")},eventsFactory.getEventsByCategoryId=function(b){return a.get("/event_category/"+b)},eventsFactory.getUniversities=function(){return a.get("/universities")},eventsFactory.getFaculties=function(){return a.get("/faculties")},eventsFactory.getStudentType=function(){return a.get("/student_types")},eventsFactory.getJobInfoSessionCountByTime=function(){return a.get("/job_info_sessions_count")},eventsFactory}]);