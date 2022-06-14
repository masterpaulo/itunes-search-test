# itunes-search-test

A demo project developed to showcase my technical background in iOS development. This application is built using SwiftUI, Combine, CoreData, and following a custom MVVM architecture.


## Getting Started

The project can be built using XCode and run on a simulator or device with internet connection.

#### Running The App
1. Clone the repository to your local machine
2. Open `itunes-search-test.xcodeproj` in XCode
3. Build and run the project
> NOTE: If unable to build due to package dependencies. Please reset package cache by going to Xcodes menu **File -> Packages -> Reset Package Caches**

## Architecture
This demo app has utilized the following tech stack:
- Swift
- MVVM (Model-View-ViewModel)
- SwiftUI
- SPM (Swift Package Manager)
- Combine
- Alamofire
- CoreData
- Git workflow

#### Data Flow
The data flow starts from making a request (with associated parameters) to the iTunes API.

The response data received as JSON data is parsed/decoded into data modal type defined in the app (in this case, only 1 model is defined called `Item`).

These decoded data are then passed the the view models to be utilized for displaying information and building the UI content.

On the App's Main screen -> Search list view, the user can select individual items to preview. This navigates the app to the Details page. Upon exiting/closing the details page, the App saves the selected item to the persistence layer with accompanying data describing the last visit date for the item.

Similarly, when the user toggles the favorite buttons (from the Details screen or the Main screen Search list) the App saves the item to persistence.

From persistence, the items that are marked as favorite are displayed in the Favorites list screen

Also, items that where saved with last visit date values are displayed in the Recent Items section in the Main screen Search page

Persisted data can be erased using default interface controls provided.


## Requirements

- Xcode 13.3.1+
- Minimum iOS deployment target 15.0

## Dependencies Used

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [Kingfisher](https://github.com/onevcat/Kingfisher)


## Authors

- **John Paulo Bonacua**
