import XCTest
@testable import AwesomeNBA

class URLService_Tests: XCTestCase {

    var urlService: URLServiceProtocol!

    override func setUpWithError() throws {
        urlService = URLService()
    }

    override func tearDownWithError() throws {
        urlService = nil
    }

    
    func test_URLService_createURLComponents_With_getTeamsEndpoint_allComponentsShouldBeCorrect() {
        // Given
        let endPoint = EndPoint.getTeams
        
        let item1 = URLQueryItem(name: "page", value: "1")
        let item2 = URLQueryItem(name: "per_page", value: "100")
        
        // When
        let components = urlService.createURLComponents(endpoint: endPoint)
        
        // Then
        XCTAssertEqual(components.scheme, "https")
        XCTAssertEqual(components.host, "www.balldontlie.io")
        XCTAssertEqual(components.path, "/api/v1/teams")
        XCTAssertEqual(components.queryItems, [item1, item2])
    }
    
    func test_URLService_createURLComponents_With_getGamesEndpoint_allComponentsShouldBeCorrect() {
        // Given
        let teamId = Int.random(in: 1...999)
        let page = Int.random(in: 1...99)
        
        // When
        let endPoint = EndPoint.getGames(teamId: teamId, page: page)
        
        let item1 = URLQueryItem(name: "team_ids[]", value: String(teamId))
        let item2 = URLQueryItem(name: "page", value: String(page))
        
        let components = urlService.createURLComponents(endpoint: endPoint)
        
        // Then
        XCTAssertEqual(components.scheme, "https")
        XCTAssertEqual(components.host, "www.balldontlie.io")
        XCTAssertEqual(components.path, "/api/v1/games")
        XCTAssertEqual(components.queryItems, [item1, item2])
    }

}
