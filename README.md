UOC-IOS-Swift-Libraries
=======================

Libraries IOS Swift to allow to connect with UOC API

* [Introduction](#introduction)
* [How To Use](#how-to-use)
* [More Information](#more-information)

## Introduction

This iOS library contains the login functions for UOC Campus and the calls to the OpenAPI in Swift.

The library also contains some examples explaining how to use some of the functions. Those functions are: 

* /user Get
* /mobileresources Get
* /calendar/events Post
* /classrooms Get
* /people Get


## How To Use

Step 1: Download this repository.

Step 2: Open the project file (Open APIS.xcodeproj) with Xcode 6 beta 2 or above.

Step 3: Modify the Constants.swift file with your secret and client and change the server Url.

Step 4: Change the NextViewController with the first view of your program after login.

(Optional) Step 5: If you want to change the name of the project, you will have to change it in all the views.

(Optional) Step 6: Remove the println from the library, and handle errors.

## More Information

You can find more information in our [blog][OpenApi].

You can find Objective-C repository [here][ObjC].
[OpenApi]: http://open-api.uoc.edu/documentacio/uoc-public-api/
[ObjC]: https://github.com/UOC/UOC-IOS-Libraries
