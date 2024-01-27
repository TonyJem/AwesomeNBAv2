import SwiftUI

@main
struct AwesomeNBAApp: App {
    
    private let networkService = NetworkService()
    private let urlService = URLService()
    
    private let serviceProvider: ServiceProviderProtocol
    
    init() {
        self.serviceProvider = ServiceProvider(
            networkService: networkService,
            urlService: urlService
        )
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(serviceProvider: serviceProvider)
        }
    }
}
