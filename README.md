# Translate App
This is the repository of a Translate App application used for demo purposes related to Supernova team. 
In this application the Clean Code Architecture approach was follow, which is visualized in the following image:

![Clean Architecture](clean-architecture.png)

**Presentation:** Is including pages and widgets to display something on the screen. These widgets dispatch events to the Bloc and listen for states.

**Domain:** Domain is the inner layer which shouldn't be susceptible to the whims of changing data sources or porting the app to Angular Dart. It will contain only the core business logic (use cases) and business objects (entities). It should be totally independent of every other layer.

**Data:** The data layer consists of a Repository implementation (the contract comes from the domain layer) and data sources - usually for getting remote (API) data or local data. Repository is where you decide if you return fresh or cached data, when to cache it and so on and other different posible checks.

Complete description of the *Clean Code Architecture* can be found here: [Link](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)

# State management
 There are a lot of discussions between which state management fulfill different kind of projects..I preffer BLoC for going with complex application. Using BLoC separates thr business logic from UI and the code can be tested very eassily. Anyhow there is still plenty of boilerplate code and is not so suitable for simple apps.  


# Getting Started
If you want to run the application on your local machine you have to setup the environment for flutter development. The app was build with Flutter 2.0.3. For this setup please follow the offical webiste: [Install Flutter](https://flutter.dev/docs/get-started/install)

For checkout: ```git clone https://github.com/FlorinAdrianLaudat/translation_app.git```

# Official Flutter Documentation

[online documentation](https://flutter.dev/docs)
