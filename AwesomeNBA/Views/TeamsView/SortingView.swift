import SwiftUI

struct SortingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: TeamsViewModel
    
    var body: some View {
        VStack {
            sortButton(sortOption: .byName)
            .padding()
            
            sortButton(sortOption: .byCity)
            .padding()
            
            sortButton(sortOption: .byConference)
            .padding()
            
        }.padding()
    }
    
    // MARK: - Private
    
    private func sortButton(sortOption: SortOption) -> some View {
        // TODO: Use localized with "@" instead of hardcoded String
        Button("Sort by \(sortOption.title.capitalized)") {
            viewModel.change(sortOption: sortOption)
            presentationMode.wrappedValue.dismiss()
        }
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
