import Foundation

struct PlayersPayload: Codable {
    let players: [Player]
    
    enum CodingKeys: String, CodingKey {
        case players = "data"
    }
}

struct Player: Identifiable, Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let team: Team

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case team
    }
}

extension Player: Equatable {
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }
    
}
