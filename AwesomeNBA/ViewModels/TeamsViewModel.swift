import Foundation

@MainActor
final class TeamsViewModel: ObservableObject {
    
    @Published var teams: [Team] = []
    
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
    
    func loadAllTeams(sorted: SortOption) {
        Task {
            await fethAllTeams()
            sortTeams(by: sorted)
        }
    }
    
    func refreshData(with sortOption: SortOption) {
        teams.removeAll()
        loadAllTeams(sorted: sortOption)
    }
    
    // MARK: - Private
    
    private func fethAllTeams() async {
        var allTeams: [Team] = []
        var currentPage = 1
        var nextPage: Int?

        repeat {
            let url = urlService.createTeamsURL(page: currentPage)
            guard let payload: TeamsPayload = await networkService.downloadData(fromURL: url) else {
                return
            }
            allTeams.append(contentsOf: payload.teams)
            nextPage = payload.pagination.nextPage
            currentPage += 1
        } while nextPage != nil
        teams = allTeams
    }
    
    private func sortTeams(by option: SortOption) {
        switch option {
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
