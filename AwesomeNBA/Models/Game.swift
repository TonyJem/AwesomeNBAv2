import Foundation

struct GamesPayload: Codable {
    let games: [Game]
    
    enum CodingKeys: String, CodingKey {
        case games = "data"
    }
}

struct Game: Identifiable, Codable {
    let id: Int
    let homeTeam: Team
    let homeTeamScore: Int
    let visitorTeam: Team
    let visitorTeamScore: Int

    enum CodingKeys: String, CodingKey {
        case id
        case homeTeam = "home_team"
        case homeTeamScore = "home_team_score"
        case visitorTeam = "visitor_team"
        case visitorTeamScore = "visitor_team_score"
    }
}

extension Game: Equatable {
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        lhs.id == rhs.id &&
        lhs.visitorTeamScore == rhs.visitorTeamScore
    }
    
}
