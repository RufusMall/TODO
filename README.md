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

## Using the app
-The add button in the bottom left is used to Add a TODO - click done in the top right once you have finished typing.
-swipe to delete
-You can toggle to mark the TODO as completed by tappin in side the circle.
-You can tap on a todo to rename it.
-todo's can be as long as you want - the cell will automatically expand.
