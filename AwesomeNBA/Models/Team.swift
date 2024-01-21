import Foundation

struct TeamsPayload: Codable {
    let teams: [Team]
    let pagination: Pagination
    
    enum CodingKeys: String, CodingKey {
        case teams = "data"
        case pagination = "meta"
    }
}

struct Pagination: Codable {
    let currentPage: Int
    let nextPage: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case nextPage = "next_page"
    }
}

struct Team: Identifiable, Codable {
    
    enum Conference: String, Codable {
        case east = "East"
        case west = "West"
        case empty = "    "
        
        var description: String {
            return self.rawValue
        }
    }
    
    let id: Int
    let city: String
    let conference: Conference
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id
        case city
        case conference
        case fullName = "full_name"
    }
}
