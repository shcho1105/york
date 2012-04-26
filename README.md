york
====

Description:

This is pilot project to test Twitter Streaming API and Mongo DB. It fetches tweets with geo coordinates in SF Bay area and stores in Mongo DB capped collection. The default web page shows tweets by given location. The map page shows Google map with tweets within the map boundary. 

How To Run:

  $ rake db:migrate         <= create Mongo DB index
  $ rake tweet:stream:start <= start Twitter Streaming client
  $ rails server            <= run web server
