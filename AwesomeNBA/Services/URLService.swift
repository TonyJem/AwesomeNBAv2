import Foundation

protocol URLServiceProtocol {
    
    func createURLComponents(endpoint: EndPointProtocol) -> URLComponents
    
}

final class URLService: URLServiceProtocol {
    
    func createURLComponents(endpoint: EndPointProtocol) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        return components
    }
    
}
