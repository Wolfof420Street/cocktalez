# cocktalez

Cocktalez is a well-structured Flutter application that allows you to explore a wide range of cocktail recipes. This project serves as a portfolio showcase, demonstrating the implementation of key Flutter concepts and libraries, such as Riverpod for state management, clean architecture, cool animations, theming and tests. 

## Features
- Browse an extensive collection of cocktail recipes.
- View details of each cocktail, including ingredients, instructions, and an image.
- Search for cocktails by name or ingredient.
- View cocktails by Glass
- View Cocktails By Ingredients
- Enjoy smooth and visually appealing animations throughout the app.


## Installation
- Ensure that you have Flutter and Dart installed on your machine. For installation instructions, refer to the [official Flutter documentation](https://docs.flutter.dev/get-started/install)
- Clone the Cocktalez repository using the following command:
``` git clone https://github.com/Wolfof420Street/cocktalez.git ```
- Navigate to the cloned repository on your machine and install all dependencies by running:
``` flutter pub get ```
- To run the app, use the command:
 ``` flutter run ```
- Please ensure you have a connected device or an emulator running.

## Project Structure and Architecture
Cocktalez is based on clean architecture principles. The project is divided into the following layers:

- **Presentation Layer** : Contains UI related elements such as Widgets and animation files.
- **Domain Layer** :  Called the provider in the code for each module. Contains business logic, entities and use cases.
- **Service Layer** : Called the service class. This class handles the data from [The Cockail DB API](https://www.thecocktaildb.com/api.php)

## Testing
The application has a comprehensive set of tests that cover both unit and widget tests, ensuring code quality and functionality at all times.

To run the tests, use the following command in the terminal:
``` flutter test ```


## Screenshots
### Dark Mode

<p float="left">
  <img src="https://github.com/Wolfof420Street/cocktalez/assets/47379369/50623d1c-7afe-4e89-9802-37a45f52235f" width="100" />
  <img src="https://github.com/Wolfof420Street/cocktalez/assets/47379369/0a34b378-d35c-4ccc-a1bc-e60432aeed88" width="100" /> 
  <img src="https://github.com/Wolfof420Street/cocktalez/assets/47379369/ec5edd35-3201-463e-aef8-c803cf7ce567" width="100" />
  <img src="https://github.com/Wolfof420Street/cocktalez/assets/47379369/be1b9a5c-306f-4358-849a-818f5b7bf4b6" width="100" />
</p>

### Light Mode

<p float="left">
  <img src="https://github.com/Wolfof420Street/cocktalez/assets/47379369/de04ba0b-eebe-49bd-a003-19b685978fcb" width="100" />
  <img src="https://github.com/Wolfof420Street/cocktalez/assets/47379369/0a6971d0-863a-4045-9210-a17d5dae8db4" width="100" /> 
  <img src="https://github.com/Wolfof420Street/cocktalez/assets/47379369/a5a97afe-094e-4cf6-aa54-cf1a6b44b48b" width="100" />
  <img src="https://github.com/Wolfof420Street/cocktalez/assets/47379369/6fdb526a-2e9c-450d-bade-e678496f6bc6" width="100" />

</p>

## Conclusion
Cocktalez provides a robust example of a Flutter application using clean architecture, state management with Riverpod, and high-quality animations. It demonstrates best practices for structuring and managing Flutter projects. Enjoy exploring Cocktalez!

For any questions or comments, feel free to reach out.

## Credit
UI inspo from [Flutter Vignettes](https://github.com/gskinnerTeam/flutter_vignettes/tree/master)


## License

<br/>

This project is released under the [MIT license](LICENSE.md). You can use the code for any purpose, including commercial projects.

[![license](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

