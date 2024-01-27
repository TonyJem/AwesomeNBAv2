import SwiftUI

struct PlayersView: View {
    
    @EnvironmentObject private var viewModel: PlayersViewModel
    
    @State private var searchText: String = ""
    
    private let serviceProvider: ServiceProviderProtocol
    
    init(serviceProvider: ServiceProviderProtocol) {
        self.serviceProvider = serviceProvider
    }
    
    var body: some View {
        VStack {
            headerView()
                .padding(.horizontal, .spacingMedium)
            
            List(viewModel.players) { player in
                NavigationLink(
                    destination: GamesView(
                        team: player.team,
                        serviceProvider: serviceProvider
                    ),
                    label: {
                        PlayersViewCell(player: player)
                    }
                )
                .onAppear {
                    if player == viewModel.players.last {
                        viewModel.loadData(searchText: searchText)
                    }
                }
            }
            .listStyle(.inset)
            .refreshable {
                viewModel.refreshData(searchText: searchText)
            }
        }
        .navigationTitle(L10n.PlayersView.navigationTitle)
        .onAppear {
            if viewModel.players.isEmpty {
                viewModel.loadData(searchText: searchText)
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { _ in
            viewModel.refreshData(searchText: searchText)
        }
    }
    
    private func headerView() -> some View {
        HStack(alignment: .center, spacing: nil) {
            ColumnHeaderText(title: L10n.PlayersView.HeaderView.columnFirstName)
                .frame(maxWidth: 80, alignment: .leading)
            Spacer()
            ColumnHeaderText(title: L10n.PlayersView.HeaderView.columnLastName)
                .frame(maxWidth: 120, alignment: .leading)
            Spacer()
            ColumnHeaderText(title: L10n.PlayersView.HeaderView.columnTeam)
                .frame(maxWidth: 100, alignment: .leading)
        }
    }
    
}

struct PlayersView_Previews: PreviewProvider {
    
    static let networkService = NetworkService()
    static let urlService = URLService()
    
    static let serviceProvider = ServiceProvider(
        networkService: networkService,
        urlService: urlService
    )
    
    static var previews: some View {
        PlayersView(serviceProvider: serviceProvider)
    }
}
