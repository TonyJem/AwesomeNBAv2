import SwiftUI

struct SortingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var sortOption: SortOption
    
    var body: some View {
        
        VStack {
            Button(action: {
                //                sortOption = .byName
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(L10n.SortingView.byName)
            })
            .padding()
            
            Button(action: {
                //                sortOption = .byCity
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(L10n.SortingView.byCity)
            })
            .padding()
            
            Button(action: {
                //                sortOption = .byConference
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(L10n.SortingView.byConference)
            })
            .padding()
            
        }.padding()
    }
}

struct TeamsView_Previews: PreviewProvider {
    
    static let networkService = NetworkService()
    static let urlService = URLService()
    
    static let serviceProvider = ServiceProvider(
        networkService: networkService,
        urlService: urlService
    )
    
    static var previews: some View {
        TeamsView(
            serviceProvider: serviceProvider
        )
    }
}
