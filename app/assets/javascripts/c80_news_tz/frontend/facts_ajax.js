"use strict";

// Код, реализующий ajax функционал на странице "новости"

var fNewsBindHistoryAdapter;
var fNewsdoAjaxRequest;
var fNewsProccessPaginateLinks;
var fNewsStartWillPaginateAjax;
var fNewsProcessBlocks; // при клике по preview-картинке новости будет происходить переход на просмотр новости

$(function () {
   if ($("body#news").length == 1) {

       fNewsBindHistoryAdapter = function () {
           History.Adapter.bind(window,'statechange',function(){ // Note: We are using statechange instead of popstate

               // Log the State
               var State = History.getState(); // Note: We are using History.getState() instead of event.state
               var p;

               //History.log('statechange:', State.data, State.title, State.url);
               if (State.title == "") {
                   p = 1;
               } else {
                   p = State.data.page;
               }

               fNewsdoAjaxRequest(p);
           });
       };

       fNewsdoAjaxRequest = function (page/*integer*/,callback/*function*/) {
           $.ajax({
               url: "/news_guru",
               type: "POST",
               data: {page: page},
               dataType: "script"
           }).done(callback);
       };

       fNewsProccessPaginateLinks = function () {
           //console.log("fNewsProccessPaginateLinks");
           $(".div_will_paginate a").click(function (e) {
               e.preventDefault();
               var page = $(this).attr('href').split("?page=")[1];
               History.pushState({page:page},window.document.title,"?page="+page);
           });
       };

       fNewsStartWillPaginateAjax = function () {
           if ($(".div_will_paginate a").length > 0) {
               fNewsProccessPaginateLinks();
               fNewsBindHistoryAdapter();
           }
       };

       fNewsProcessBlocks = function() {
           $(".fact img").click(function (e) {
               // NB:: parent().parent() хардкод: картинка лежит в ссылке, ссылка лежит в диве
               window.location.href = $(this).parent().parent().data('url');
           });
       };

       fNewsStartWillPaginateAjax();
       fNewsProcessBlocks();

   }
});