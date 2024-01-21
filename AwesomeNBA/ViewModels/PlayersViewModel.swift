import Foundation

@MainActor
final class PlayersViewModel: ObservableObject {
    @Published var players: [Player] = []
    
    private let networkService: NetworkServiceProtocol
    private let urlService: URLServiceProtocol
    
    private var currentPage = 0
    
    init(
        networkService: NetworkServiceProtocol,
        urlService: URLServiceProtocol
    ) {
        self.networkService = networkService
        self.urlService = urlService
    }
    
    // MARK: - Public
    
    func loadData(searchText: String) {
        Task {
            await fetchPlayers(searchText: searchText)
        }
    }
    
    func refreshData(searchText: String) {
        currentPage = 0
        players.removeAll()
        loadData(searchText: searchText)
    }
    
    // MARK: - Private

    private func fetchPlayers(searchText: String) async {
        currentPage += 1
        
        let components = urlService.createURLComponents(
            endpoint: EndPoint.getPlayers(
                searchText: searchText,
                page: currentPage
            ))
        
        guard let payload: PlayersPayload = await networkService.downloadData(components: components) else {
            return
        }
        players.append(contentsOf: payload.players)
    }
    
}
