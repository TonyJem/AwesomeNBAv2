import Foundation

@MainActor
final class TeamsViewModel: ObservableObject {
    
    @Published var teams: [Team] = []
    
    @Published var sortOption: SortOption = .byName {
        didSet {
            guard oldValue != sortOption else { return }
            teams = sorted(teams, by: sortOption)
        }
    }
    
    private let networkService: NetworkServiceProtocol
    private let urlService: URLServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol,
        urlService: URLServiceProtocol
    ) {
        self.networkService = networkService
        self.urlService = urlService
        loadTeams()
    }
    
    // MARK: - Public
    
    func loadTeams() {
        Task {
            await getSortedTeams()
        }
    }
    
    func change(sortOption: SortOption) {
        self.sortOption = sortOption
    }
    
    // MARK: - Private
    
    private func getSortedTeams() async {
        let components = urlService.createURLComponents(endpoint: EndPoint.teams)
        do {
            let payload: TeamsPayload = try await networkService.fetchData(components: components)
            teams = sorted(payload.teams, by: sortOption)
        } catch {
            if let error = error as? NetworkError {
                print(error.description)
            } else {
                print("Unexpected fetch error: \(error.localizedDescription)")
            }
        }
    }
    
    private func sorted(_ teams: [Team], by sortOption: SortOption) -> [Team] {
        switch sortOption {
        case .byName:
            return sortedByName(teams)
        case .byCity:
            return sortedByCity(teams)
        case .byConference:
            return sortedByConference(teams)
        }
    }
    
    private func sortedByName(_ teams: [Team]) -> [Team] {
        var tempTeams = teams
        tempTeams.sort {
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
        return tempTeams
    }
    
    private func sortedByCity(_ teams: [Team]) -> [Team] {
        var tempTeams = teams
        tempTeams.sort {
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
        return tempTeams
    }
    
    private func sortedByConference(_ teams: [Team]) -> [Team] {
        var tempTeams = teams
        tempTeams.sort {
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
        return tempTeams
    }
    
}
