import XCTest
@testable import AwesomeNBA

class URLService_Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    
    func test_URLService_createURLComponents_With_getTeamsEndpoint_allComponentsShouldBeCorrect() {
        // Given
        let endPoint = EndPoint.getTeams
        let urlService = URLService()
        
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

}
