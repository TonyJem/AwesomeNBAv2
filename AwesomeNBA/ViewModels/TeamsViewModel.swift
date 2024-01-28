import Foundation

@MainActor
final class TeamsViewModel: ObservableObject {
    
    @Published var teams: [Team] = []
    
    @Published var sortOption: SortOption = .byName {
        didSet {
            guard oldValue != sortOption else { return }
            sortTeams()
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
        refreshTeams()
    }
    
    // MARK: - Public
    
    func refreshTeams() {
        Task {
            await getTeams()
            sortTeams()
        }
    }
    
    func change(sortOption: SortOption) {
        self.sortOption = sortOption
    }
    
    // MARK: - Private
    
    private func getTeams() async {
        let components = urlService.createURLComponents(endpoint: EndPoint.getTeams)
        do {
            let payload: TeamsPayload = try await networkService.fetchData(components: components)
            teams = payload.teams
        } catch {
            if let error = error as? NetworkError {
                print(error.description)
            } else {
                print("Unexpected fetch error: \(error.localizedDescription)")
            }
        }
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
