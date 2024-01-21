import Foundation

protocol URLServiceProtocol {
    
    func createPlayersURL(searchText: String, page: Int?) -> String
    
    func createGamesURL(teamId: Int, page: Int?) -> String
    
    func createURLComponents(endpoint: EndPointProtocol) -> URLComponents
    
}

final class URLService: URLServiceProtocol {
    
    private let baseURL = "https://www.balldontlie.io/api/v1/"
    
    func createGamesURL(teamId: Int, page: Int? = nil) -> String {
        var stringURL = baseURL + EndPoint.games.rawValue
        
        stringURL += "?team_ids[]=\(teamId)"
        
        if let page = page {
            stringURL += "&page=\(page)"
        }
        
        return stringURL
    }
    
    func createPlayersURL(searchText: String, page: Int? = nil) -> String {
        var stringURL = baseURL + EndPoint.players.rawValue
        
        stringURL += "?search=\(searchText.lowercased())"
        
        if let page = page {
            stringURL += "&page=\(page)"
        }
        
        return stringURL
    }
    
    func createURLComponents(endpoint: EndPointProtocol) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        return components
    }
    
}

// - MARK: - EndPoint

extension URLService {
    
    enum EndPoint: String {
        case teams = "teams"
        case games = "games"
        case players = "players"
    }
    
}
