import Foundation

@MainActor
final class GamesViewModel: ObservableObject {
    @Published var games: [Game] = []
    
    private var currentPage = 0
    
    private let urlService: URLServiceProtocol
    private let networkServiceWithAlamofire: NetworkServiceWithAlamofireProtocol
    
    init(
        urlService: URLServiceProtocol,
        networkServiceWithAlamofire: NetworkServiceWithAlamofireProtocol
        
    ) {
        self.urlService = urlService
        self.networkServiceWithAlamofire = networkServiceWithAlamofire
    }
    
    // MARK: - Public
    
    func loadData(by teamId: Int) {
        fetchGamesWithAlamofire(by: teamId)
    }
    
    func refreshData(for teamId: Int) {
        games.removeAll()
        currentPage = 0
        loadData(by: teamId)
    }
    
    // MARK: - Private
    
    private func fetchGamesWithAlamofire(by teamId: Int) {
        currentPage += 1
        let url = urlService.createGamesURL(teamId: teamId, page: currentPage)
        networkServiceWithAlamofire.downloadGames(fromURL: url) { [weak self] result in
            switch result {
            case .success(let payload):
                self?.games.append(contentsOf: payload.games)
            case .failure(let error):
                print("🔴 Error: \(error)")
            }
        }
    }
    
}
