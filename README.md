#Grocy - Grocery Shopping App

Grocy is an iOS grocery shopping app built using SwiftUI and Firebase that offers a seamless, modern, and efficient experience for users to manage their grocery shopping. With features like category exploration, cart management, and real-time Firebase sync, Grocy aims to be the ultimate tool for both casual and power users.

This app features modern Swift programming practices, like data synchronization via Firebase, state management using ObservableObject, and a user-friendly UI built with SwiftUI.

Table of Contents

Features
Tech Stack
Screenshots
Requirements
Installation
Setup Firebase
Usage
Contributing
License
Features

Grocy provides a variety of powerful and intuitive features to streamline the grocery shopping process:

Shop Tab: Browse and add items to your cart with ease.
Explore Tab: Discover products by category. The app only shows unique categories and loads images directly from internet URLs.
Cart Tab: View all items in your cart, modify quantities, and check out with ease.
Favorite Tab: Save your frequently bought items for quick access.
Account Tab: Manage your user profile, settings, and view order history.
Firebase Integration: Sync orders in real-time with Firebase to keep everything up-to-date across devices.
Unique Categories: Display only unique product categories in the Explore view.
Quantity Badge: Real-time badge update on cart items across views to ensure accurate tracking.
Offer Ribbon: Highlight special offers on products for better savings.
Custom Observable Data Model: Use a custom Observable data model to store user data locally with JSON encoding and decoding for better performance and maintainability.
Tech Stack

This app is built using the following technologies:

SwiftUI: For building the declarative user interface.
Firebase: For cloud storage and real-time database synchronization.
SwiftData (Core Data): For local data storage and offline support.
ObservableObject: To sync data and update the views across the app.
JSON Encoding/Decoding: For storing user data locally in a secure and efficient manner.
Screenshots

Explore the categories of grocery items, showcasing unique categories with images.

View and manage your cart with real-time updates to the quantity and special offers.

Requirements

iOS 17+
Xcode 15+
Installation

Follow the steps below to install and run the project locally.

Clone the repository:
git clone https://github.com/sahaj1519/Grocy.git
Navigate to the project folder:
cd Grocy
Open the project in Xcode:
open Grocy.xcodeproj
Install any required dependencies using Swift Package Manager (if applicable).
Build and run the project on a simulator or device.
Setup Firebase

Go to the Firebase Console: Firebase Console.
Create a new Firebase project.
Follow the instructions to add Firebase to your iOS app, including downloading the GoogleService-Info.plist file.
Add the GoogleService-Info.plist file to the Xcode project.
Make sure to enable Firestore and set up the database rules as required for your app.
Usage

Adding Items to Cart: Browse through the Shop tab, select your desired items, and click to add them to your cart.
Managing Cart: Go to the Cart tab to view all added items, modify quantities, and check out.
Exploring Categories: In the Explore tab, select any category to view products, which are automatically filtered for uniqueness.
Saving Favorites: Tap the heart icon next to a product to save it as a favorite for future reference.
Contributing

We welcome contributions from the community! If you'd like to contribute to Grocy, follow these steps:

Fork the repository.
Create a new feature branch (git checkout -b feature-name).
Make your changes, ensuring to follow best practices for code style and commit messages.
Commit your changes (git commit -m 'Add new feature').
Push your changes to your forked repository (git push origin feature-name).
Open a pull request to merge your changes into the main repository.
Please ensure your contributions are tested and don't break existing functionality. For bug fixes, please provide clear steps to reproduce the issue.

License

This project is licensed under the MIT License - see the LICENSE file for details
