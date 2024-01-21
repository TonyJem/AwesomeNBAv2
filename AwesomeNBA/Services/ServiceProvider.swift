import Foundation

protocol ServiceProviderProtocol {
    
    var networkService: NetworkServiceProtocol { get }
    
    var urlService: URLServiceProtocol { get }
    
    var networkServiceWithAlamofire: NetworkServiceWithAlamofireProtocol { get }
    
}

final class ServiceProvider: ServiceProviderProtocol {
    
    let networkService: NetworkServiceProtocol
    let urlService: URLServiceProtocol
    let networkServiceWithAlamofire: NetworkServiceWithAlamofireProtocol
    
    init(
        networkService: NetworkServiceProtocol,
        urlService: URLServiceProtocol,
        networkServiceWithAlamofire: NetworkServiceWithAlamofireProtocol
    ) {
        self.networkService = networkService
        self.urlService = urlService
        self.networkServiceWithAlamofire = networkServiceWithAlamofire
    }
    
}
