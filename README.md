## To-Do App
The To-Do App is a simple mobile application developed using Flutter framework, with a self-hosted backend server using Appwrite, a backend-as-a-service platform, and Appwrite's database service for data storage.

## Features
The To-Do App allows users to create, update, and delete to-do items. The main features of the app include:

Create new to-do items with a title and description.
Mark to-do items as complete or incomplete.
Edit existing to-do items to update their title or description.
Delete to-do items that are no longer needed.
View a list of all to-do items, including their status (complete/incomplete).
Backend Server
The To-Do App uses Appwrite as the self-hosted backend server. Appwrite is an open-source backend-as-a-service platform that provides various services such as authentication, database, storage, and more.

The backend server is responsible for handling the CRUD (Create, Read, Update, Delete) operations for to-do items. It communicates with the Appwrite database service to store and retrieve data.

## Dependencies
The To-Do App relies on the following dependencies:

<b>Flutter SDK</b>: The app is developed using Flutter, a UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.

<b>Appwrite SDK</b>: The app uses the Appwrite SDK for Flutter to communicate with the self-hosted backend server and perform CRUD operations on to-do items.

<b>Provider</b>: Provider is a state management library for Flutter that is used to manage the state of the app and trigger UI updates when the state changes.

<b>Flutter Icons</b>: Flutter Icons is a set of high-quality icons for Flutter that is used to display icons in the app's UI.

## Installation
To run the To-Do App locally, follow these steps:

Clone the repository to your local machine.
Make sure you have Flutter SDK and Dart installed on your machine.
Run flutter pub get in the project's root directory to install the app's dependencies.
Update the lib/config.dart file with your self-hosted Appwrite backend server details, including the endpoint and project ID.
Run flutter run to start the app on an emulator or a physical device.
Note: Before running the app, make sure you have set up a self-hosted Appwrite backend server with the required collections and permissions for CRUD operations on to-do items.

## Credits
The To-Do App was developed by <b><i>Nazim Qureshi</i></b>. It was built while learning Flutter and using online resources and documentation for guidance. The app uses Appwrite as the backend server, and the Appwrite SDK for Flutter for communication with the backend server. The UI design and icons are inspired by various sources and modified to suit the app's requirements.

## License
The To-Do App is open-source and released under the MIT License. Feel free to use, modify, and distribute the app as per the terms of the license. However, please note that the app is provided "as is" without any warranty or support, and the author will not be liable for any damages or issues arising from its use.





