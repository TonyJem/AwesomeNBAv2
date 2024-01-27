import SwiftUI

struct MainView: View {
    
    private let serviceProvider: ServiceProviderProtocol
    
    init(serviceProvider: ServiceProviderProtocol) {
        self.serviceProvider = serviceProvider
    }
    
    var body: some View {
        
        TabView {
            NavigationView {
                TeamsView(serviceProvider: serviceProvider)
            }
            .tabItem {
                Label(
                    L10n.TabView.homeTabTitle,
                    systemImage: .systemImage(.home)
                )
            }
            
            NavigationView {
                PlayersView(serviceProvider: serviceProvider)
            }
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
