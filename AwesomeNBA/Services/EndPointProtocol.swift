import Foundation

enum HTTPScheme: String {
    case http
    case https
}

/// The EndPointProtocol protocol allows us to separate the task of constructing a URL,
/// its parameters from the act of executing the URL request and parsing the response.
protocol EndPointProtocol {
    
/// .http  or .https
var scheme: HTTPScheme { get }
    
// Example: "www.host.com"
var host: String { get }
    
// "/api/v1/path"
var path: String { get }
    
// [URLQueryItem(name: "item_key", value: VALUE)]
var queryItems: [URLQueryItem] { get }
    
}

enum EndPoint: EndPointProtocol {
    
    case getTeams
    case getGames(teamId: Int, page: Int)
    case getPlayers(searchText: String, page: Int)
    
    var scheme: HTTPScheme {
        switch self {
        case .getTeams, .getGames, .getPlayers:
            return .https
        }
    }
    
    var host: String {
        switch self {
        case .getTeams, .getGames, .getPlayers:
            return "www.balldontlie.io"
        }
    }
    
    var path: String {
        switch self {
        case .getTeams:
            return "/api/v1/teams"
        case .getGames:
            return "/api/v1/games"
        case .getPlayers:
            return "/api/v1/players"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getTeams:
            let params = [
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "per_page", value: "100")
            ]
            return params
            
        case .getGames(let teamId, let page):
            let params = [
                URLQueryItem(name: "team_ids[]", value: String(teamId)),
                URLQueryItem(name: "page", value: String(page))
            ]
            return params
            
        case .getPlayers(let searchText, let page):
            let params = [
                URLQueryItem(name: "search", value: searchText),
                URLQueryItem(name: "page", value: String(page))
            ]
            return params
        }
    }
    
}
