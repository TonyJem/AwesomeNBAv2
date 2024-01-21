import SwiftUI

enum SortOption {
    case byName
    case byCity
    case byConference
    
    var title: String {
        switch self {
        case .byName:
            return L10n.SortOption.byName
        case .byCity:
            return L10n.SortOption.byCity
        case .byConference:
            return L10n.SortOption.byConference
        }
    }
}

struct TeamsView: View {
    
    @StateObject private var viewModel: TeamsViewModel
    
    @State var showSortingView = false
    @State var sortOption: SortOption = .byName
    
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
                viewModel.refreshData(with: sortOption)
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(sortOption.title) {
                    showSortingView = true
                }
            }
        }
        .navigationTitle(L10n.TeamsView.navigationTitle)
        .onChange(of: sortOption) { _ in
            viewModel.loadAllTeams(sorted: sortOption)
        }
        .onAppear {
            if viewModel.teams.isEmpty {
                viewModel.loadAllTeams(sorted: sortOption)
            }
        }
        .sheet(isPresented: $showSortingView, content: {
            SortingView(sortOption: $sortOption)
        })
    }
    
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

struct SortingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var onDismiss: ((_ model: SortOption) -> Void)?
    
    @Binding var sortOption: SortOption
    
    var body: some View {
        
        VStack {
            Button(action: {
                sortOption = .byName
                onDismiss?(sortOption)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(L10n.SortingView.byName)
            })
            .padding()
            
            Button(action: {
                sortOption = .byCity
                onDismiss?(sortOption)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(L10n.SortingView.byCity)
            })
            .padding()
            
            Button(action: {
                sortOption = .byConference
                onDismiss?(sortOption)
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
    static let networkServiceWithAlamofire = NetworkServiceWithAlamofire()
    
    static let serviceProvider = ServiceProvider(
        networkService: networkService,
        urlService: urlService,
        networkServiceWithAlamofire: networkServiceWithAlamofire
    )
    
    static var previews: some View {
        TeamsView(
            serviceProvider: serviceProvider
        )
    }
}
