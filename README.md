# VisualFit

An iOS native fitness app build using to help users track their fitness progress, set goals, and stay motivated.

## Getting Started

- [Installing](#installation)
- [Project Setup](#project-setup)
- [Additional Notes](#additional-notes)
- [Environment Variables](#environment-variables)
- [Tech Stack](#tech-stack)
- [Features](#features)
- [Architecture](#architecture)
- [Authors](#authors)

## Installation

Clone the repository with Git

HTTPS

```bash
  git clone https://github.com/harsh9539/visFitLatest.git
  cd visFitLatest
```

SSH

```bash
  git clone git@github.com:harsh9539/visFitLatest.git
  cd visFitLatest
```

## Project Setup

- Open with xcode
- In Xcode, go to File → Add Package Dependencies
- Install Package Dependenies - FSCalender (https://github.com/WenchaoD/FSCalendar.git)
  ![App Screenshot](https://res.cloudinary.com/drgzprwnz/image/upload/v1715572213/WhatsApp_Image_2024-05-13_at_9.18.42_AM_ndgvs0.jpg)
- Add Package
  ![App Screenshot](https://res.cloudinary.com/drgzprwnz/image/upload/v1715572213/WhatsApp_Image_2024-05-13_at_9.18.43_AM_vtqqxw.jpg)
- [Read more about FSCalendar](https://github.com/WenchaoD/FSCalendar)

### Additional Notes

- This App uses "Vision Kit" for human body part detection and Camera capabilities
- These capabilities does not work on "Simulator"
- You will need an physical iOS Device for testing it.
- You can follow Apple's Offical Documention guide for it.
- [Run iOS App from xcode to on Physical Device.](https://developer.apple.com/documentation/xcode/running-your-app-in-simulator-or-on-a-device)

## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

`GET_IMG_AI_API_KEY`

You can sign up on [getimg.ai](https://docs.getimg.ai/reference/poststablediffusioninpaint) and get a free API Key.

## Tech Stack

**Client:** Swift, Xcode, Storyboard, UIKit

**Server:** Node, Express, MongoDB

**Machine Learning:** Realistic Vision v5.1 Inpainting

**External API:** [getimg.ai](https://docs.getimg.ai/reference/poststablediffusioninpaint)

## Features

**Visualize Transformation**

- Utilizing Vision Kit, we detect the torso area in user-clicked photos and apply masking.
- The Realistic Vision Inpainting model is then used to show transformations based on the user's desired changes.
  **Peer Group**
- Includes a leaderboard showcasing top performers.
- Area section for system-generated motivational updates to create a sense of community and encouragement among peers.
  **Discover Feed**
- A platform for sharing fitness journey posts.
- Users can export transformation short video clips for everyone to see, providing inspiration and motivation.

## Architecture

### Model-View-Controller (MVC)

- **Models**: Located in the `models` folder, these are data models created using the `struct` keyword. They represent the structured data used in the app, such as UserData, which is a singleton class containing all user-related data.

- **Controllers**: Found in the `controllers` folder, these handle the logic and flow of the app. They interact with both the models and the views. For example, TransformImageApiCall.swift is a controller responsible for calling the machine learning model for image transformation.

- **Views**: The UI is primarily built using Storyboard, focusing on creating user interfaces and interactions. Most of the layout and design work is done within Storyboard. Custom UI components and reusable elements are stored in the `components` folder.

### Folder Structure

- **models**: Contains data models built using the `struct` keyword, such as UserData.
- **controllers**: Handles app logic and interactions, including TransformImageApiCall.swift for ML model integration.
- **components**: Stores reusable custom UI components.
- **Main**: Used for UI design and layout, where most of the UI work is done.

## Authors

