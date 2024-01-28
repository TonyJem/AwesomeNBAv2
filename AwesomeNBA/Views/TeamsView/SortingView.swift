import SwiftUI

struct SortingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: TeamsViewModel
    
    var body: some View {
        VStack {
            ForEach(SortOption.allCases) { sortOption in
                sortButton(with: sortOption)
                    .padding()
            }
        }
        .padding()
    }
    
    // MARK: - Private
    
    private func sortButton(with sortOption: SortOption) -> some View {
        Button(L10n.SortingView.getButtonTitle(from: sortOption.title)) {
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
