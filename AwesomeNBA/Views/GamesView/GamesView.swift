import SwiftUI

struct GamesView: View {
    
    @StateObject private var viewModel: GamesViewModel
    
    private let team: Team
    private let serviceProvider: ServiceProviderProtocol
    
    init(
        team: Team,
        serviceProvider: ServiceProviderProtocol
    ) {
        self.team = team
        self.serviceProvider = serviceProvider
        
        _viewModel = StateObject(wrappedValue: GamesViewModel(
            urlService: serviceProvider.urlService
        ))
    }
    
    var body: some View {
        VStack{
            headerView()
                .padding(.horizontal, .spacingMedium)
            
            List(viewModel.games) { game in
                GamesViewCell(game: game)
                    .onAppear {
                        if game == viewModel.games.last {
                            viewModel.loadData(by: team.id)
                        }
                    }
            }
            .listStyle(.inset)
            .refreshable {
                viewModel.refreshData(for: team.id)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(team.fullName)
                    .foregroundColor(Color.black)
                    .fontWeight(.bold)
            }
        }
        .onAppear {
            if viewModel.games.isEmpty {
                viewModel.loadData(by: team.id)
            }
        }
    }
    
    private func headerView() -> some View {
        HStack(alignment: .center, spacing: nil) {
            ColumnHeaderText(title: L10n.GamesView.HeaderView.columnHomeName)
                .frame(maxWidth: 60, alignment: .center)
            Spacer()
            ColumnHeaderText(title: L10n.GamesView.HeaderView.columnHomeScore)
                .frame(maxWidth: 60, alignment: .center)
            Spacer()
            ColumnHeaderText(title: L10n.GamesView.HeaderView.columnVisitorName)
                .frame(maxWidth: 60, alignment: .center)
            Spacer()
            ColumnHeaderText(title: L10n.GamesView.HeaderView.columnVisitorScore)
                .frame(maxWidth: 60, alignment: .center)
        }
    }
    
}

struct TeamDetails_Previews: PreviewProvider {
    
    static let networkService = NetworkService()
    static let urlService = URLService()
    
    static let serviceProvider = ServiceProvider(
        networkService: networkService,
        urlService: urlService
    )
    
    static var previews: some View {
        GamesView(
            team: Team(
                id: 1,
                city: "City",
                conference: .east,
                fullName: "FullName"
            ),
            serviceProvider: serviceProvider
        )
    }
}
