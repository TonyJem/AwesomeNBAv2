import SwiftUI

@main
struct AwesomeNBAApp: App {
    
    private let networkService = NetworkService()
    private let urlService = URLService()
    private let networkServiceWithAlamofire = NetworkServiceWithAlamofire()
    
    private let serviceProvider: ServiceProviderProtocol
    
    init() {
        self.serviceProvider = ServiceProvider(
            networkService: networkService,
            urlService: urlService,
            networkServiceWithAlamofire: networkServiceWithAlamofire
        )
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(serviceProvider: serviceProvider)
        }
    }
}
