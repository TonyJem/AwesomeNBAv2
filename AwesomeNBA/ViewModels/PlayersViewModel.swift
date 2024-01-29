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
        loadPlayers()
    }
    
    // MARK: - Public
    
    func loadPlayers(searchText: String = "") {
        Task {
            await getPlayers(searchText: searchText)
        }
    }
    
    func refreshData(searchText: String) {
        currentPage = 0
        loadPlayers(searchText: searchText)
    }
    
    // MARK: - Private
    
    private func getPlayers(searchText: String) async {
        currentPage += 1
        let components = urlService.createURLComponents(
            endpoint: EndPoint.players(
                searchText: searchText,
                page: currentPage
            ))
        do {
            let payload: PlayersPayload = try await networkService.fetchData(components: components)
            if currentPage == 1 {
                players = payload.players
            } else {
                players.append(contentsOf: payload.players)
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
