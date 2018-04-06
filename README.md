# Legend

    MA - Movies Application
    CD - Core Data

# Application Requirements

    The application's purpose is to show movies in grid fetched from server or database. The grid is
    implemented using MACollectionView which inherits from UICollectionView and implement it's methods.
    Xib file is provided for cell implementation which includes imageview for the movie's poster.
    There are 2 methods for using the collection view - setMoviesResult and setFavouriteMovies as well
    as a delegate which is called whenever next page is required or an item has been selected.

    Filter requirements of the task are implemented as a tab bar controller with 3 tabs - popular, 
    top rated and favourites. The first 2 load the information from the 3rd party API, the favourites
    tab uses movies stored in local database implemented with CoreData.
    
    All 3 controllers - MAPopularMoviesViewController, MATopRatedMoviesViewController,
    MAFavouriteMoviesVIewController, inherit the MAMoviesViewController. Each of the 3 holds a separate
    MACollectionView with outlet in MAMoviesViewController. Each controller implements it's own logic 
    for download/loading the movies.

    Showing movie details is implemented in seperate view controller - MAMovieDetailsViewController. 
    Movie details screen displays title, movie poster, release date, original title, rating, overview.
    All the content is placed in UIScrollView. The navigation bar features a right bar button used for 
    adding/removing the movie to favourites. MAMovieDetailsViewController implements the logic for 
    checking whether the movie is already in favourites or not and shows the respective button. 
    A dialog is showed when the movie is successfully added/removed from favourites.

    Back navigation for the user is provided with use of UINavigationController. 
    MATabBarController sets the back navigation title to always be "Back".

# Code implementation

## Base Classes

    - inherit from UIKit classes or used as a parent class. 
    They implement all the base features for the specifed file type - controller/class/struct etc.
    For example MABaseViewController adds all controllers which inhert it
    to the delegates array in MACommunicationManager.

## Managers - used as singleton, implementing their own queues.

    MAApplicationManager - methods for base application functions, 
    for example preparing the app at start or showing the activity indicator.
    
    MADatabaseManager - provides the connection between the application and the database.
    
    MACommunicationManager - provides the connection between the application and the server. 
    Implements methods for sending request, handling their responses and calling
    the appropriate delegate methods.
    
    MAAsyncManager - used to download movie posters. Can implement function for photos upload.
    Works hand in hand with MAFileManager in order to save/load images faster. 
    Already saved images are loaded from local storage instead of being download from the server.
    
    MAFileManager - saves/loads downloaded movie posters to/from a local directory.
    
## Core Data
    
    Implements 2 models - CDMovie and CDGenre. 
    CDGenre is a connecting table between movies and genres using their ids.
    
## Requests
    
    MABaseURLRequest - implements the logic of all requests executed to the server. 
    It requires which child request to override certain variables - successAction and failedAction.
    Those are the delegate methods that should be called when requests succeeds or fails. 
    OnSuccessData is optional because some requests might not have data in their server response.
    
## Extensions 

    Extensions of UIKit classes or custom classes and implementing a common and helpful logic.
    
## Labels

    MALabel - implements convenient to customize the current label
    
## Localization

    MAStrings - struct that holds constants which call Localizable.strings with an appropriate key
    and ask for the correspondent translation. When using constants instead of keys
    the chance of mistake is significantly smaller.
    
## Constants

    The file MAConstants contains constants used in the application.
    Constants are subdivied in different structures for a better code implementation.
    



