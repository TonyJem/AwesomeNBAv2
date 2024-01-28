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
            await fetchGames()
        }
    }
    
    func refreshData() {
        games.removeAll()
        currentPage = 0
        loadGames()
    }
    
    // MARK: - Private
    
    private func fetchGames() async {
        currentPage += 1
        let components = urlService.createURLComponents(
            endpoint: EndPoint.getGames(teamId: team.id, page: currentPage)
        )
        guard let payload: GamesPayload = await networkService.fetchData(components: components) else {
            return
        }
        games.append(contentsOf: payload.games)
    }
    
}
