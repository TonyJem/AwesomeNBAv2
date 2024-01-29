# AwesomeNBAv2
 This repo is the 2nd iteration of [AwesomeNBA](https://github.com/TonyJem/AwesomeNBA/tree/main)  test App with recent changes:

 1. Updated URLService. Here is used one universal apporach utilising URLComponents which helped avoid to define few different methods with custom logic each in order to create single endpoints;

 2. Created and added Units tests to new URLService;
 
 3. Removed dependency to Alamofire and now Networking is done on more consistent way;

 4. All sorting logic is moved into TeamsViewModel, no more @Binding! MVVM architcture is fully implemented here;
 
 5. TeamsViewModel and PlayerViewModel are injected as Environment object, and can be accessed in relevent flows;
 
 6. Avoided using .onAppear for loading data into viewModels. Now all new data will be uploaded during initialization of new ViewModel;
 
 7. Refactored logic creating actions in SortingView sheet. Now all sorting buttons will be generated automaticaly and fully depends on cases in SortinOpion enum;

 8. Improved Network error handling. Used throwing async functions and errors are handled in each ViewModel separatelly on one same consitent approach.


Plan for next improvements: 

1. Add SnapshotTesting and cover main screens;
2. Add more unit tests;
3. Introduce and add some UI tests;
4. Create and add EmptyView, Loading and Error screens;
5. Show spinner in the last row for endless scroll screens while fetching and adding new data.
6. Make sure all SwiftUI Preview screens works correctly.
