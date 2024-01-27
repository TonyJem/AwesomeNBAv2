import Foundation

protocol ServiceProviderProtocol {
    
    var networkService: NetworkServiceProtocol { get }
    
    var urlService: URLServiceProtocol { get }
    
}

final class ServiceProvider: ServiceProviderProtocol {
    
    let networkService: NetworkServiceProtocol
    let urlService: URLServiceProtocol

    
    init(
        networkService: NetworkServiceProtocol,
        urlService: URLServiceProtocol
    ) {
        self.networkService = networkService
        self.urlService = urlService
    }
    
}
