import Foundation

@MainActor
final class GamesViewModel: ObservableObject {
    @Published var games: [Game] = []
    
    private var currentPage = 0
    
    private let urlService: URLServiceProtocol
    private let networkServiceWithAlamofire: NetworkServiceWithAlamofireProtocol
    
    // TODO: Inject it in init as a dependecy
    private let networkService = NetworkService()
    
    init(
        urlService: URLServiceProtocol,
        networkServiceWithAlamofire: NetworkServiceWithAlamofireProtocol
    ) {
        self.urlService = urlService
        self.networkServiceWithAlamofire = networkServiceWithAlamofire
    }
    
    // MARK: - Public
    
    func loadData(by teamId: Int) {
        Task {
            await fetchGames(by: teamId)
        }
    }
    
    func refreshData(for teamId: Int) {
        games.removeAll()
        currentPage = 0
        loadData(by: teamId)
    }
    
    // MARK: - Private
    
    private func fetchGames(by teamId: Int) async {
        currentPage += 1
        let components = urlService.createURLComponents(
            endpoint: EndPoint.getGames(teamId: teamId, page: currentPage)
        )
        guard let payload: GamesPayload = await networkService.downloadData(components: components) else {
            return
        }
        games.append(contentsOf: payload.games)
    }
    
}
