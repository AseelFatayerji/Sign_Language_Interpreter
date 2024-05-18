<img src="./readme/title1.svg"/>

<br><br>

<!-- project philosophy -->
<img src="./readme/title2.svg"/>
img src="./readme/title2.svg"/>

>This mobile application enables users to receive real-time interpretation, simplifying the process of learning sign language and bridging the gap between verbal and non-verbal communitaion.
> 
>Silent Learning is an app that helps people learn sign language. It gives feedback to help learners improve. There are two parts: one for students to learn and one for teachers to add new signs, which keeps the app's sign language collection fresh and full.


### User Stories
- As a user, I want to easily understand sign language so that I can accommodate those with hearing and speaking disabilities.
- As a registered teacher, I want to ensure that the app has the most up-to-date word bank so that anyone using the app can express themselves properly.
- As a system admin, I want to manage teacher accounts so that I can ensure the smooth operation of the translation service and maintain data security.

<br><br>
<!-- Tech stack -->
<img src="./readme/title3.svg"/>

###  Silent Learning is built using the following technologies:

- This project uses the [Mediapipe](https://mediapipe.readthedocs.io/) and [Tensorflow](https://www.tensorflow.org/api_docs) integarted in a Python API to create a wireframe that tracks the user's hand and displays the prediction in the [Flutter](https://docs.flutter.dev/) UI.
- For persistent storage (database), the app uses the MongoDB package which allows the app to connect to a database containing all the users.
- The Tensorflow package comes equiped with Keras which allows us to load in the models and update them without the need for a deticated database.

<br><br>
<!-- UI UX -->
<img src="./readme/title4.svg"/>


> We designed Silent Learning using wireframes and mockups, iterating on the design until we reached the ideal layout for easy navigation and a seamless user experience.

- Project Figma design [Figma](https://www.figma.com/file/xcOANpKdHBofpmiJXo8pvz/Silent-Learning?type=design&node-id=0-1&mode=design&t=8ozsZ9HivkYXuGxC-0)


### Mockups
| Home screen  | Opening Screen | Language Screen |
| ---| ---| ---|
| ![Landing](./readme/images/Home%20screen.png) | ![Landing](./readme/images/Openning%20Screen.png) | ![Landing](./readme/images/Language%20screen.png) |

<br><br>

<!-- Database Design -->
<img src="./readme/title5.svg"/>

###  Architecting Data Excellence: Innovative Database Design Strategies:

![fsdaf](./readme/images/mongo_database_v1.png)


<br><br>


<!-- Implementation -->
<img src="./readme/title6.svg"/>


### User Screens (Mobile)
| Home screen  | Translating Screen |Language Selection Secreen | Openning Screen | 
| ---| ---| ---| ---|
| ![Landing](./readme/images/Home%20screen.png) | ![Landing](./readme/images/Learning%20Screen.png) | ![Landing](./readme/images/Language%20screen.png) | ![Landing](./readme/images/Openning%20Screen.png) |

### Admin/Teacher Screens (Mobile)
| Profile | Admin Screen | User List Screen | Teaching Screen | 
| ---| ---| ---| ---|
| ![Landing](./readme/images/profile.png) | ![Landing](./readme/images/Admin.png) |![Landing](./readme/images/User%20list.png) | ![Landing](./readme/images/Teaching%20screen.png) | 


<br><br>


<!-- Prompt Engineering -->
<img src="./readme/title7.svg"/>

###  Mastering AI Interaction: Unveiling the Power of Prompt Engineering:

- This project uses advanced prompt engineering techniques to optimize the interaction with natural language processing models. By skillfully crafting input instructions, we tailor the behavior of the models to achieve precise and efficient language understanding and generation for various tasks and preferences.

<br><br>

<!-- AWS Deployment -->
<img src="./readme/title8.svg"/>

###  Efficient AI Deployment: Unleashing the Potential with AWS Integration:

- This project leverages AWS deployment strategies to seamlessly integrate and deploy natural language processing models. With a focus on scalability, reliability, and performance, we ensure that AI applications powered by these models deliver robust and responsive solutions for diverse use cases.

<br><br>

<!-- Unit Testing -->
<img src="./readme/title9.svg"/>

###  Precision in Development: Harnessing the Power of Unit Testing:

- This project employs rigorous unit testing methodologies to ensure the reliability and accuracy of code components. By systematically evaluating individual units of the software, we guarantee a robust foundation, identifying and addressing potential issues early in the development process.

<br><br>


<!-- How to run -->
<img src="./readme/title10.svg"/>

> To set up Silent Learning locally, follow these steps:

### Prerequisites

Prerequisites
    1. Flutter SDK: Ensure you have Flutter installed on your machine. If not, follow the installation instructions here.
    2. Development Environment: Set up your preferred code editor or IDE with Flutter and Dart plugins installed.

### Installation
Getting Started
    1. Clone the Repository: Clone the repository containing the Flutter project from the provided GitHub link or using the command below:
    git clone <repository_url>
    2.Navigate to Project Directory: Move into the project directory:
    3.Running the App
        Frontend Install Dependencies: Install the required dependencies for the project by running:
            flutter pub get
        Backend Install Node module: Install the required dependencies for the project by running:
            npm i
Run the backend: Navigate to Project Directory and run
            npm start
Run the App: Launch the app on a connected device or emulator by executing:
        flutter run
    If you have multiple devices connected, specify the device using:   
        flutter run -d <device_id>
    Replace <device_id> with the ID of your desired device.
Testing
    Unit Tests: Execute any available unit tests using:
        flutter test
Build for Production
    Android: To build the app for Android, run:
        flutter build apk

    This generates an APK file located in the build/app/outputs/flutter-apk directory.

    iOS: For building the app for iOS, use:
        flutter build ios
    This generates an iOS application bundle in the build/ios directory.

Additional Notes
Configuration: Modify any necessary configurations such as API endpoints or environment variables in the lib/config.dart file.
Troubleshooting: If you encounter any issues during setup or execution, refer to the official Flutter documentation or community forums for assistance.

Now, you should be able to run Silent Learning locally and explore its features.
