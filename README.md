# YassirChallenge

This project is a simple two page app with a few network calls and remote data manipulations, UIKit and SwiftUI were used to implement the user interface and apple's URLSession was used to make network calls. The project's structure is based on the MVVM architecture. Memory leaks were kept in check as there were no unnecessary object initialiation or strong reference cycles.

The project launches with the main page, the app automatically makes a network call and returns a list of characters, scrolling to the very bottom of the list triggers another batch of characters to be added to the existing list (Pagination) and network calls were clipped by caching data, only data that has not been fetched before gets fetched from the api, if it has been fetched before.

## How to Install

  1.  Clone this repo to your local machine.
  2.  Navigate to the project directory after cloning and open the .xcodeproj with Xcode.
  3.  press shift + option + command K to run a clean build on the project.
  4.  Select a destination to run it to a device or a simulator and then click on the play button to build.
