#  Weather Forecast

## Note 

Before running this demo, you must route to the project's directory and  run  pod install.

## Introduction 

Weather Forecast is an app that locates your current city and displays its forecast for the next 5 days for every 3 hours.
It also that fetches the weather for any city in the world, it indicates the temperature, the wind speed and the weather description.

## How to use
- User can check the forecast of its current location when accessing current city from the landing screen. 
- User can also check weather for different city when accessing other cities from the landing screen. 
- User can choose the unit, he wants to see the weather in, from the toggle located in the landing screen.

## Permissions

The app asks for location permission to access the user longitude and latitude and displays the forecast.

## Design patterns 

Weather Forecast is using MVVM design patern. Each Flow has its own Model, View, View Model and protocol. The View Communicates to with the View Model that communicates with the Model. The View Model communicates with the View through protocols.

## Automation

This project is using fastlane command line to run Unit and UITests classes.
To run fastlan you must route to the project's directory and  run  fastlane tests.

## App Environment 

This project is based on 1 environment.
You can modify the environment varialbes by going to -> Build Settings -> User-defined.
The environment varialbes are: ["APP_ID_OWM", "BASE_END_POINT"].

## Extensions
The project contains extensions files helps to set/get custom vlaues for any native iOS component.

## Managers

Managers folder contains the location shared manager classe in the app.

## AppConfig

AppConfig.swift contains all the main functions for the app, starting from the defiend AppDelegate methods, ending with the main & basic app config and initializers.

## Utils

Utils.swift contains functions that helps you with development across the entire app. such as Global Alert Controller, Global NSMutableAttributedString builders, Global pull down to refresh installed on UITableView etc..

## Constants

Constants foldr contains all the global constants used in the app, such global enums, Identifiers etc ...

## Pods

This project uses three pods .
'ReachabilitySwift' as a replacement for Apple's Reachability sample.
'IQKeyboardManager' for a clean behavior of the keyboard.
'SwiftLint' for a perfect swift styling based on GitHub's Swift Style Guide.
    

