# weather_app
This application dynamically updates the page based on weather conditions. 
It changes background images and data according to the current weather. 
The app uses the Geolocator package to get the user's location and also provides a search box for manually entering a location. 
The weather data is fetched from the OpenWeatherMap API.

## Features
- Automatically fetches weather data based on the user's location.
- Allows manual location entry to get weather updates.
- Dynamically changes background images and data based on weather conditions.
- Uses the OpenWeatherMap API for accurate weather information.

## Installation
1st step: 
   clone the repository:
        
      git clone [https://github.com/RAVI-SAI-1819/weather_app]
        
      cd weather_app

2nd step:
    
    flutter pub get
   to get all the package which are used in this project 
 
3rd step: 
    i used the geolocator package in pubspec.yaml file which will lead to  
    "Your project requires a newer version of the Kotlin Gradle plugin."
    so to fix do these following :
    
    1. open build.gradle file change the kotlin to  current version
    allprojects {
        ext.kotlin_version = '2.0.20'    
        repositories {
            google()
            mavenCentral()
        }
    }
add the following in allprojects -  ext.kotlin_version = '<current_version>'

4th step:
add the following to AndroidManifest.xml for giving the permission location and network access 
    
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>

5th step: 
    Create a file .env in lib folder and add the following in .env file
    
    WEATHER_API_KEY='Your OpenWeatherApiKey"

https://home.openweathermap.org/api_keys

6th step:
    
    flutter run 
    
to run the application

7th step:
to build apk run:

        flutter build apk


Automatic Location:
When the app is launched, it will request location permissions from the user.
If the user grants permission, the app will automatically fetch weather data for the current location.
The UI will dynamically update with the relevant weather information, including temperature, conditions (e.g., sunny, rainy), and wind speed.
Manual Location Entry:
Use the search box provided in the app to manually enter a location (e.g., city name or coordinates).
Upon entering a location, the app will fetch and display the weather data for that specific place.
Users can explore weather details such as humidity, pressure, and sunrise/sunset times.
Background Images:
The app enhances the user experience by changing background images based on the current weather conditions.
For example, a sunny day might display a bright, clear sky image, while a rainy day could show raindrops on a windowpane.

# Follow me on:
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/akkina-ravi-sai-chowdary/)
[![Blog](https://img.shields.io/badge/Blog-FF5722?style=for-the-badge&logo=blogger&logoColor=white)](http://knrlearning.blogspot.com/)

![screenshot](https://github.com/user-attachments/assets/8d4ec0bd-a9d1-4998-9e3a-906c4d713728)

