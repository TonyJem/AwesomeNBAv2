import Foundation

enum SortOption {
    case byName
    case byCity
    case byConference
    
    var title: String {
        switch self {
        case .byName:
            return L10n.SortOption.byName
        case .byCity:
            return L10n.SortOption.byCity
        case .byConference:
            return L10n.SortOption.byConference
        }
    }
}

extension LocalizedTranslations {
    
    enum SortOption {
        
        static let byName = "SortOption.byName.Title".localized
        
        static let byCity = "SortOption.byCity.Title".localized
        
        static let byConference = "SortOption.byConference.Title".localized
        
    }
    
}
