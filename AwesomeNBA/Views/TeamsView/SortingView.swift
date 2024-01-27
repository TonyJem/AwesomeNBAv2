import SwiftUI

struct SortingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: TeamsViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.change(sortOption: .byName)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(L10n.SortingView.byName)
            })
            .padding()
            
            Button(action: {
                viewModel.change(sortOption: .byCity)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(L10n.SortingView.byCity)
            })
            .padding()
            
            Button(action: {
                viewModel.change(sortOption: .byConference)
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
