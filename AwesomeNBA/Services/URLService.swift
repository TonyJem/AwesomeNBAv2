import Foundation

protocol URLServiceProtocol {
    
    func createTeamsURL(page: Int?) -> String
    
    func createPlayersURL(searchText: String, page: Int?) -> String
    
    func createGamesURL(teamId: Int, page: Int?) -> String
    
}

final class URLService: URLServiceProtocol {
    
    private let baseURL = "https://www.balldontlie.io/api/v1/"
    
    func createTeamsURL(page: Int? = nil) -> String {
        var stringURL = baseURL + EndPoint.teams.rawValue
        
        if let page = page {
            stringURL += "?page=\(page)"
        }
        
        return stringURL
    }
    
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
    
}

// - MARK: - EndPoint

extension URLService {
    
    enum EndPoint: String {
        case teams = "teams"
        case games = "games"
        case players = "players"
    }
    
}
