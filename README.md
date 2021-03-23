
# Flutter MVVM Boiler Plate
  
Flutter Boiler Plate containing pre initialised services and following standardised protocol for code quality.
  

##  Features

| Feature | Availability | |
| - | - | -|
| Ready to use | :white_check_mark: | 
| MVVM based | :white_check_mark:|
| Network services | :white_check_mark: |
| Using Providers | :white_check_mark: |
| Modular | :white_check_mark: |
| Embedded custom URL Screen | :white_check_mark: |





## Setup Guide

 1.  Pubspec.yaml
 2.  Constants
 3.  Base Response Model
 4.  Network layer
 5.  Navigation
## .



## Pubspec.yaml

#### What to change here?

 - Change your project description
 - Add and register project specific assets
 - Application version
 - Required third party libs.

## Constants

#### Description

Maintainability is achieved by distributing type of Constant Data into specific category. 
Important constants files are
 - api_constants.dart
      - Contains base URL and all the end points that application is going to use.
      
 - app_constants.dart
      - Contains maintenance flag for changing Production and Staging Environments
      - Also contains app related constants 
      
 - singleton_constants.dart
      - This is a Singleton class for general purpose data sharing over the app User object, token etc.
- Other constants files are self explanatory

## Base Response Model

#### Description

Base Response Model is designed for productive API integration. This model can be modified according to Project's API structure.

File name

- response_data_model.dart

###  Keys to change

 1. Data
 2. Error and Message
 3. okAndContainsData
 
 Based on your API Structure change the 'data' key to specified key where all your response's data will be delivered.
 Example: For given API structure 
  ```json
{
  'data': [
    {
      'name': 'Abhijeet Tripathi',
      'mail': 'somemail@test.com'
    }
{
      'name': 'Shekhar Sahu',
      'mail': 'somemail@test.com'
    }
  ],

'message' : 'Data fetched'
'error' : 'None till now'
}
```

 the keys will be..

 ```dart
 data: parsedJson['data'] != null ? parsedJson['data'] : null,
 okAndContainsData: (response.statusCode == 200 ) && (parsedJson['data'] != null),
 message: parsedJson['message'] != null ? parsedJson['message'] : "",
```
 
 Though this model is null safe but it's not safe from parsing errors. 
 Always cross checks keys name and hierarchy of them.

 ## Network Layer

#### Description

Networking layer is preinitialised with following features.

-  Network connection check
 - Common loader
 - Common Error and Success Message
 - Prettyfied Logs for easy debugging.

Responsible files

 - api_helper.dart
 - api_service.dart
 - api_constants.dart
 - network_check.dart
 - pretty_json_print.dart

###  Things to change
In  **api_helper.dart** change the following as per your project needs.

 - DEFAULT_TIMEOUT this is a top level variable denotes time out seconds. Default is 45.
 - _getHeaders this is Header generator for API call change as per required.
 - _handleError this is error handler for all REST calls you can handle unauthorised logout and 
	error alert directly from here.

###  Usage example

 1. Declare end point you want consume in api_constants.dart in given format.
 ```dart
 static const String LOGIN = "/api/login";
 ```
 
 2.  Create **URI** with **base URL** and **end point** in your function.
	   
```dart
//  baseURL here is Getter of String type that returns your base URL from
//  api_constants.dart and is directly accesibile.

Uri _loginUri = Uri.parse(baseURL + ApiConstants.LOGIN);

```
 3.  Use ApiHelper class it contains plug and play REST callers.
 ```dart
Map map =  { "email": "eve.holt@reqres.in","password": "cityslicka" }
ResponseData responseData =  
    await ApiHelper().postRequest(context, _loginUri, map,  
          useAuth: false, showLoader: true, responseName: "Login",
          showLog: true, showError: true); 

```

3.  Check response and consume.
 ```dart
if (responseData.okAndContainsData ) {
// Do success stuff here.
}else if(responseData.statusCode == 500){
// Handle 500.
}else{
// Handle everthing else.
}

```

 ## Navigation

#### Description
Navigation is straight forward

Responsible file

 - navigation_helper.dart
 
####  Things to take care of

 - Always provide Navigation TAG - All views have their own specific tag
 ```dart
 static const String TAG = "/LoginView";
 ```
These tags help to easily access and switch to views
 - Register path in routes - in main.dart register paths to their respective view.
  ```dart
routes: {  
  LoginView.TAG: (context) => NavigationHelper.getLoginViewWithProvider(),  
},
```

 - Keep Function naming standard
```dart
///Naming Standard:  
///Fun that gives View with provider             - getViewNameWithProvider()  
///Fun that pushes View                          - gotoViewName()  
///Fun(Data data) that pushes View with data     - gotoViewNameWithData(data)  
///Fun that clears stack and pushes View         - clearAndGotoViewName()
```


