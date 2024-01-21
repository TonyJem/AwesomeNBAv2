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
    
// Example: "maps.googleapis.com"
var host: String { get }
    
// "/maps/api/place/nearbysearch/"
var path: String { get }
    
// [URLQueryItem(name: "api_key", value: API_KEY)]
var queryItems: [URLQueryItem] { get }
    
}

//"https://www.balldontlie.io/api/v1/"

enum EndPoint: EndPointProtocol {
    
    /*
     enum EndPoint: String {
         case teams = "teams"
         case games = "games"
         case players = "players"
     }
     */
    
    case getTeams
    
    var scheme: HTTPScheme {
        switch self {
        case .getTeams:
            return .https
        }
    }
    
    var host: String {
        switch self {
        case .getTeams:
            return "www.balldontlie.io"
        }
    }
    
    var path: String {
        switch self {
        case .getTeams:
            return "/api/v1/teams"
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
        }
    }
    
}
