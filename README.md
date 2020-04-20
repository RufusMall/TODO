Example TODO App written in Obj-C - using realm as the data store

## Build Info
[![Build Status](https://app.bitrise.io/app/4e02dee824fefb53/status.svg?token=yrpvQcFuLC9uygFBTdns5A&branch=master)](https://app.bitrise.io/app/4e02dee824fefb53#)

The build status above is taken from a bitrise CI system that builds the app and runs the unit tests.

The application has been tested on an iPhone X with iOS 13.3.1, and some older simulators, but it should run on any iOS device supporting the deployment target.

Local builds have been built using Xcode Version 11.4 (11E146), the CI Agents are using the same Xcode version.

## Build Instructions

The REALM dependancy is included via cocoapods.

To build the project:
navigate to the route of the directory, and run "pod install" in terminal
Open Todo.xcworkspace to open the project, and then build as normal.

## About
The app was built using MvvM architecture - the view models hold all the state for the UI, and the UI just reflects the data in the ViewModel. This means I could test alot of the code.
In a real app I would have moved more code out of the view model and into seperate services, and probably considered abstracting realm.
I used no other third party dependancies other than realm - to keep it simple.

There was a requirement to demonstrate how I would implement caching... I did this by using the built in "stuff" in NSURLSession. 
This is currently setup to respect the cache-control set in the header of the remote resource. This is set to do a conditional get - aka - make a lightweight request to see if the remote resource has changed, 
if it has... download it - otherwise just use the cached version.
Doing caching this way gives us alot of flexibility and options (we could easily set it up to only fetch remote resource if nothing is local, 
or set something in the remote headers so the device only checks the remote resource on a certain schedule etc).

I tested the device to make sure it was only downloading the image data if the remote resource has changed - tested using Charles.

My thought process/rough task breakdown and time log is on a trello board: https://trello.com/b/fKE70KQb/testcard-todo
This also shows some future features I wanted to/may add.

## Using the app
-The add button in the bottom left is used to Add a TODO - click done in the top right once you have finished typing.
-swipe to delete
-You can toggle to mark the TODO as completed by tappin in side the circle.
-You can tap on a todo to rename it.
-todo's can be as long as you want - the cell will automatically expand.

The UI/UX could be improve... but I didn't quite have enough time.
