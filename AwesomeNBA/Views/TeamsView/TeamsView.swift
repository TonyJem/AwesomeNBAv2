import SwiftUI

struct TeamsView: View {
    
    @StateObject private var viewModel: TeamsViewModel
    
    @State private var showSortingView = false
    
    private let serviceProvider: ServiceProviderProtocol
    
    init(serviceProvider: ServiceProviderProtocol) {
        self.serviceProvider = serviceProvider
        
        _viewModel = StateObject(wrappedValue: TeamsViewModel(
            networkService: serviceProvider.networkService,
            urlService: serviceProvider.urlService
        ))
    }
    
    var body: some View {
        VStack {
            headerView()
            .padding(.horizontal, .spacingMedium)
            
            List(viewModel.teams) { team in
                NavigationLink(
                    destination: GamesView(
                        team: team,
                        serviceProvider: serviceProvider
                    ),
                    label: {
                        TeamsViewCell(team: team)
                    }
                )
            }
            .listStyle(.inset)
            .refreshable {
                viewModel.refreshData()
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(viewModel.sortOption.title) {
                    showSortingView = true
                }
            }
        }
        .navigationTitle(L10n.TeamsView.navigationTitle)
        .onAppear {
            if viewModel.teams.isEmpty {
                viewModel.loadSortedTeams()
            }
        }
        .sheet(isPresented: $showSortingView, content: {
            SortingView(sortOption: viewModel.sortOption)
        })
    }
    
    // MARK: - Private
    
    private func headerView() -> some View {
        HStack(alignment: .center, spacing: nil) {
            ColumnHeaderText(title: L10n.TeamsView.HeaderView.columnTitleName)
                .frame(maxWidth: 170, alignment: .leading)
            Spacer()
            ColumnHeaderText(title: L10n.TeamsView.HeaderView.columnTitleCity)
                .frame(maxWidth: 50, alignment: .leading)
            Spacer()
            ColumnHeaderText(title: L10n.TeamsView.HeaderView.columnTitleConference)
                .frame(maxWidth: 90, alignment: .leading)
        }
    }
    
}
