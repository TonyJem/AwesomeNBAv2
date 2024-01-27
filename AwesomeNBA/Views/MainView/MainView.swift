import SwiftUI

struct MainView: View {
    
    @StateObject var teamsViewModel: TeamsViewModel
    @StateObject var playersViewModel: PlayersViewModel
    
    private let serviceProvider: ServiceProviderProtocol
    
    init(serviceProvider: ServiceProviderProtocol) {
        self.serviceProvider = serviceProvider
        
        _teamsViewModel = StateObject(wrappedValue: TeamsViewModel(
            networkService: serviceProvider.networkService,
            urlService: serviceProvider.urlService
        ))
        
        _playersViewModel = StateObject(wrappedValue: PlayersViewModel(
            networkService: serviceProvider.networkService,
            urlService: serviceProvider.urlService
        ))
    }
    
    var body: some View {
        
        TabView {
            NavigationView {
                TeamsView(serviceProvider: serviceProvider)
            }
            .environmentObject(teamsViewModel)
            .tabItem {
                Label(
                    L10n.TabView.homeTabTitle,
                    systemImage: .systemImage(.home)
                )
            }
            
            NavigationView {
                PlayersView(serviceProvider: serviceProvider)
            }
            .environmentObject(playersViewModel)
            .tabItem {
                Label(
                    L10n.TabView.playersTabTitle,
                    systemImage: .systemImage(.players)
                )
            }
        }
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    
    static let networkService = NetworkService()
    static let urlService = URLService()
    
    static let serviceProvider = ServiceProvider(
        networkService: networkService,
        urlService: urlService
    )
    
    static var previews: some View {
        MainView(serviceProvider: serviceProvider)
    }
}
