# A Flutter Stopwatch

This is a Flutter project that attempts to follow this product specification:

You work for a company that makes stopwatches. Oftentimes, though, a given stopwatch evolves into something much larger with many additional features beyond what would be considered part of a standard stopwatch. The company would like to be able to deploy to many environments using a single codebase if possible. You have been newly hired and have been asked to build out a production ready, functional, and deployable interface for the base case. Here are the requirements:


- As a user I want to be able to start the stopwatch so that I can begin tracking time
- As a user I want to be able to stop the stopwatch so that I can end tracking time
- As a user I want to be able to optionally track laps
- When tracking laps, I want to know what order they were tracked in
- When tracking laps, I want to know how many there are
- As a user I want to be able to reset the stopwatch
- Resetting means that all laps are reset
- Resetting means that overall time is also reset


The finished product should, at a minimum, build to iOS and Android devices (Simulator/Emulator is okay) and to web displaying a uniform interface and user experience. The finished product should include everything needed for other engineers to work on the product and for the deployment team to deploy the application (into the App or Play stores or to web). The finished product should provide confidence that the application will perform as expected.


## Setup Instructions for running the app

Clone this Github repo to your local development environment.
Open the project in your VS Code or Android Studio IDE.
In Terminal, run the following command to retrieve all pubspec dependencies:

flutter pub get

The app is configured to run in iOS, Android, a Web Browser.  
In Terminal, run the following command and when prompted, select the number associated with the desired platform:

flutter run

## Some further details

I have attempted to follow Clean Architecture guidelines, which ultimately yields an app that is testable, maintainable, and scalable, and is a proven architecture for growth, as requested in the product spec.  Some of the folders are in the domain and data layers are placeholders only, as there was no requirement (yet) to implement significant data passthrough or storage.  I have some infrastructure for a SaveStopWatchUseCase, but it is not used at this time.

I follow a basic MVVM Presentation layer and leverage the Riverpod package for the UI State Management.

I use a StreamBuilder to handle the continuous Stream of Timer updates which provide periodic snapshots of the underlying dart:core Stopwatch object.

The viewmodel manages basic functional logic of the stopwatch, laps management, and some string formatting.

I have a rudimentary Dependency Injection file created called Injector.dart which potentially takes any concrete initializers of any dependencies.

## Some additional thoughts

The primary Timer logic is handled simply in the ViewModel.  Technically, one could consider the Stopwatch data as residing in the Data/DataSource or Data/Repository layer of the architecture, and that could easily further demontrate the separation of the Stopwatch as a data source, with control and access from specific UseCases in the Domain layer.

## Links to videos of the app in action in iPhone, Android, and Chrome web browser

https://drive.google.com/drive/folders/1HtEfCjj8mn2EYxHMInHK_Uq79g-7aST1?usp=sharing
