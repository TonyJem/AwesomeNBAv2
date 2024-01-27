import Foundation

@MainActor
final class TeamsViewModel: ObservableObject {
    
    @Published var teams: [Team] = []
    @Published var sortOption: SortOption = .byName
    
    private let networkService: NetworkServiceProtocol
    private let urlService: URLServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol,
        urlService: URLServiceProtocol
    ) {
        self.networkService = networkService
        self.urlService = urlService
    }
    
    // MARK: - Public
    
    func loadSortedTeams() {
        Task {
            await fethAllTeams()
            sortTeams()
        }
    }
    
    func refreshData() {
        teams.removeAll()
        loadSortedTeams()
    }
    
    // MARK: - Private
    
    private func fethAllTeams() async {
        let components = urlService.createURLComponents(endpoint: EndPoint.getTeams)
        guard let payload: TeamsPayload = await networkService.downloadData(components: components) else {
            return
        }
        teams = payload.teams
    }
    
    private func sortTeams() {
        switch sortOption {
        case .byName:
            sortByName()
        case .byCity:
            sortByCity()
        case .byConference:
            sortByConference()
        }
    }
    
    private func sortByName() {
        teams.sort {
            if $0.fullName.lowercased() != $1.fullName.lowercased() {
                return $0.fullName.lowercased() < $1.fullName.lowercased()
            } else {
                if $0.city.lowercased() != $1.city.lowercased() {
                    return $0.city.lowercased() < $1.city.lowercased()
                } else {
                    return $0.conference.rawValue.lowercased() < $1.conference.rawValue.lowercased()
                }
            }
        }
    }
    
    private func sortByCity() {
        teams.sort {
            if $0.city.lowercased() != $1.city.lowercased() {
                return $0.city.lowercased() < $1.city.lowercased()
            } else {
                if $0.fullName.lowercased() != $1.fullName.lowercased() {
                    return $0.fullName.lowercased() < $1.fullName.lowercased()
                } else {
                    return $0.conference.rawValue.lowercased() < $1.conference.rawValue.lowercased()
                }
            }
        }
    }
    
    private func sortByConference() {
        teams.sort {
            if $0.conference.rawValue.lowercased() != $1.conference.rawValue.lowercased() {
                return $0.conference.rawValue.lowercased() < $1.conference.rawValue.lowercased()
            } else {
                if $0.fullName.lowercased() != $1.fullName.lowercased() {
                    return $0.fullName.lowercased() < $1.fullName.lowercased()
                } else {
                    return $0.city.lowercased() < $1.city.lowercased()
                }
            }
        }
    }
    
}
