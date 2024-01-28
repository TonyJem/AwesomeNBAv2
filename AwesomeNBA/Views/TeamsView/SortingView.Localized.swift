import Foundation

extension LocalizedTranslations {
    
    enum SortingView {
        
        static func getButtonTitle(from title: String) -> String {
            return title.localized(with: "SortingView.SortBy.Prefix".localized)
        }
        
    }
    
}
