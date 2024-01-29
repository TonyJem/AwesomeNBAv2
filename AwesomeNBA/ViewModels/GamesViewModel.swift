import Foundation

@MainActor
final class GamesViewModel: ObservableObject {
    
    @Published var games: [Game] = []
    
    let team: Team
    
    private let networkService: NetworkServiceProtocol
    private let urlService: URLServiceProtocol
    
    private var currentPage = 0
    
    init(
        team: Team,
        networkService: NetworkServiceProtocol,
        urlService: URLServiceProtocol
    ) {
        self.team = team
        self.networkService = networkService
        self.urlService = urlService
        loadGames()
    }
    
    // MARK: - Public
    
    func loadGames() {
        Task {
            await getGames()
        }
    }
    
    func refreshData() {
        currentPage = 0
        loadGames()
    }
    
    // MARK: - Private
    
    private func getGames() async {
        currentPage += 1
        let components = urlService.createURLComponents(
            endpoint: EndPoint.games(teamId: team.id, page: currentPage)
        )
        do {
            let payload: GamesPayload = try await networkService.fetchData(components: components)
            if currentPage == 1 {
                games = payload.games
            } else {
                games.append(contentsOf: payload.games)
            }
        } catch {
            if let error = error as? NetworkError {
                print(error.description)
            } else {
                print("Unexpected fetch error: \(error.localizedDescription)")
            }
        }
    }
    
}
