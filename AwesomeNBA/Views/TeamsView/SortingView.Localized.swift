import Foundation

extension LocalizedTranslations {
    
    enum SortingView {
        
        private static let prefix = "SortingView.SortBy.Prefix".localized
        
        static func getButtonTitle(with text: String) -> String {
            return prefix.formatted(text: text)
        }
        
    }
    
}
