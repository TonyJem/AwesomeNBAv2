import Foundation

enum HTTPScheme: String {
    case http
    case https
}

/// The EndPointProtocol protocol allows us to separate the task of constructing a URL and,
/// it's parameters from the act of executing the URL request and parsing the response.
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
    
    case teams
    case games(teamId: Int, page: Int)
    case players(searchText: String, page: Int)
    
    var scheme: HTTPScheme {
        switch self {
        case .teams, .games, .players:
            return .https
        }
    }
    
    var host: String {
        switch self {
        case .teams, .games, .players:
            return "www.balldontlie.io"
        }
    }
    
    var path: String {
        switch self {
        case .teams:
            return "/api/v1/teams"
        case .games:
            return "/api/v1/games"
        case .players:
            return "/api/v1/players"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .teams:
            let params = [
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "per_page", value: "100")
            ]
            return params
            
        case .games(let teamId, let page):
            let params = [
                URLQueryItem(name: "team_ids[]", value: String(teamId)),
                URLQueryItem(name: "page", value: String(page))
            ]
            return params
            
        case .players(let searchText, let page):
            let params = [
                URLQueryItem(name: "search", value: searchText),
                URLQueryItem(name: "page", value: String(page))
            ]
            return params
        }
    }
    
}
